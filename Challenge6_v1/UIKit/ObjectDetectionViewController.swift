//
//  ObjectDetectionViewController.swift
//  Object Detection Live Stream
//
//  Created by Alexey Korotkov on 6/25/19.
//  Copyright © 2019 Alexey Korotkov. All rights reserved.
//  Augmented by Pedro Machado on 29/01/23.

import UIKit
import AVFoundation
import Vision


class ObjectDetectionViewController: ViewController {
    
    private var detectionOverlay: CALayer! = nil
    var lastHeight: CGFloat = 0
    
    // Vision parts
    private var requests = [VNRequest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(debugTap(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func debugTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.view)
        print("Location tap: ", location)
        print("Location target: ", ballLabel.center)
    }
    
    @discardableResult
    func setupVision() -> NSError? {
        // Setup Vision parts
        let error: NSError! = nil
        
        guard let modelURL = Bundle.main.url(forResource: "Model", withExtension: "mlmodelc") else {
            return NSError(domain: "VisionObjectRecognitionViewController", code: -1, userInfo: [NSLocalizedDescriptionKey: "Model file is missing"])
        }
        do {
            let visionModel = try VNCoreMLModel(for: MLModel(contentsOf: modelURL))
            let objectRecognition = VNCoreMLRequest(model: visionModel, completionHandler: { (request, error) in
                DispatchQueue.main.async(execute: {
                    // perform all the UI updates on the main queue
                    if let results = request.results {
                        self.drawVisionRequestResults(results)
                    }
                })
            })
            self.requests = [objectRecognition]
        } catch let error as NSError {
            print("Model loading went wrong: \(error)")
        }
        
        return error
    }
    
    func drawVisionRequestResults(_ results: [Any]) {
        CATransaction.begin()
        //MARK: resetting all objects
        detectionOverlay.sublayers = nil
        
        var biggestObject: VNRecognizedObjectObservation
        if results.count > 0 {
            biggestObject = results[0] as! VNRecognizedObjectObservation
        }
        else{
            biggestObject = VNRecognizedObjectObservation(boundingBox: CGRect(origin: .zero, size: .zero))
        }
        
        for observation in results where observation is VNRecognizedObjectObservation{
            let object = observation as! VNRecognizedObjectObservation
            if biggestObject.boundingBox.area < object.boundingBox.area{
                biggestObject = object
            }
            
        }
        
//        for label in biggestObject.labels{
//            print(label.identifier)
//        }
        
            /// Pega a boundingbox do objectObservation e cria uma let
            var normalizedBoundingBox = biggestObject.boundingBox
            /// Retângulo normalizado a partir da boundingBox e do tamanho da tela
            let objectBounds = VNImageRectForNormalizedRect(normalizedBoundingBox, Int(bufferSize.width), Int(bufferSize.height))
            
            if biggestObject.confidence > 0.96 {
                let averageFromArray = ballXCenterHistory.reduce(0 as CGFloat) { $0 + CGFloat($1) } / CGFloat(ballXCenterHistory.count)
                
                
                
                switch direction {
                    case .upwards:
                        if objectBounds.midX > lastHeight + objectBounds.height/6 {
                            direction = .downwards
                        }
                    case .downwards:
                        if objectBounds.midX < lastHeight - objectBounds.height/6 {
                            direction = .upwards
                            numberOfKeepyUps += 1
                            pointCounter.bounceAnimation()
                            if numberOfKeepyUps == targetScore {
                                pointCounter.paintBalls(color: .greenCircle)
                            }
                        }
                    case .stopped:
                        objectBounds.midX > lastHeight + objectBounds.height/7 ? (direction = .downwards) : (direction = .upwards)
                }
                
                
//                print("midX: \(objectBounds.midX), LH: \(lastHeight + objectBounds.height/5)")
                
                lastHeight = objectBounds.midX
                
                directionLabel.text = direction.rawValue.capitalized
                
                ballXCenterHistory.append(objectBounds.midX)
                normalizedBoundingBox.origin.y = averageFromArray
                if ballXCenterHistory.count == 5 {
                    ballXCenterHistory = [averageFromArray]
                }
                let shapeLayer = self.createRoundedRectLayerWithBounds(objectBounds, color: UIColor.yellow)
                
//                let basicAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
                detectionOverlay.addSublayer(shapeLayer)
//                print(ballXCenterHistory)

            }
            // adiciona o ponto médio Y (eixo X real) do objectBounds, que é o retangulo normalizado da bola
            //contabiliza qualquer coisa, independente do nivel de confiança
//        print(objectBounds.height/2)
            
        
       
        animateTarget(target: ballLabel, position: objectBounds, box: biggestObject.boundingBox)
        
        pointCounter.pointCounterView.text = "\(numberOfKeepyUps)"
//        self.updateLayerGeometry()
        CATransaction.commit()
    }
    
    override func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let exifOrientation = exifOrientationFromDeviceOrientation()
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: exifOrientation, options: [:])
        do {
            try imageRequestHandler.perform(self.requests)
        } catch {
            print(error)
        }
    }
    
    var lastPosition: CGPoint?
    
    func animateTarget(target: UIView, position: CGRect, box: CGRect){
        UIView.animate(withDuration: 0.3, delay: .zero,options: .curveEaseInOut, animations: {
            
            let biggestSide = (box.height<box.width) ? box.height : box.width
            let increment = abs(position.width - position.height)/2.0
            //            target.frame.size = CGSize(width: box.width, height: box.height)
            
            var targetHeight:CGFloat {target.frame.size.height}
            var targetWidth:CGFloat {target.frame.size.width}
            
            target.frame.size.height = self.view.frame.height * biggestSide
            target.frame.size.width = self.view.frame.width * biggestSide
            
            
//            target.layer.cornerRadius = targetWidth/2
            
            target.frame.origin.x = box.origin.y * self.view.frame.width
            target.frame.origin.y = box.origin.x * self.view.frame.height
            
            (targetHeight>targetWidth) ? (target.frame.origin.x -= increment) : (target.frame.origin.y  -= increment)
            
            (targetHeight<targetWidth) ? (target.frame.size.height = targetWidth) : (target.frame.size.width = targetHeight)
            
//            print("originMinha = \(target.frame.center)")
            
//            target.layer.cornerRadius = target.frame.height/2
         //   target.center.y = position.x //+ 100
         //   target.center.x = position.y //- increment
            
//            target.frame.origin = CGPoint(x: position.x , y: position.y )
          
        })
    }
    
    override func setupAVCapture() {
        super.setupAVCapture()
        
        // setup Vision parts
        setupLayers()
        updateLayerGeometry()
        setupVision()
        
        // start the capture
        startCaptureSession()
    }
    
    func setupLayers() {
        detectionOverlay = CALayer() // container layer that has all the renderings of the observations
        detectionOverlay.name = "DetectionOverlay"
        detectionOverlay.bounds = CGRect(x: 0.0,
                                         y: 0.0,
                                         width: bufferSize.width,
                                         height: bufferSize.height)
        detectionOverlay.position = CGPoint(x: rootLayer.bounds.midX, y: rootLayer.bounds.midY)
      
        rootLayer.addSublayer(detectionOverlay)
   
    }
    
    func updateLayerGeometry() {
        let bounds = rootLayer.bounds
        var scale: CGFloat
        
        let xScale: CGFloat = bounds.size.width / bufferSize.height
        let yScale: CGFloat = bounds.size.height / bufferSize.width
        
        scale = fmax(xScale, yScale)
        if scale.isInfinite {
            scale = 1.0
        }
        CATransaction.begin()
//        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        
        // rotate the layer into screen orientation and scale and mirror
        detectionOverlay.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 2.0)).scaledBy(x: scale, y: -scale))
        // center the layer
        detectionOverlay.position = CGPoint (x: bounds.midX, y: bounds.midY)
        
        CATransaction.commit()
        
    }
    
    func createTextSubLayerInBounds(_ bounds: CGRect, identifier: String, confidence: VNConfidence) -> CATextLayer {
        let textLayer = CATextLayer()
        textLayer.name = "Object Label"
        let formattedString = NSMutableAttributedString(string: String(format: "\(identifier)\nConfidence:  %.2f", confidence))
        let largeFont = UIFont(name: "Helvetica", size: 24.0)!
        formattedString.addAttributes([NSAttributedString.Key.font: largeFont], range: NSRange(location: 0, length: identifier.count))
        formattedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], range: NSRange(location: 0, length: identifier.count))
        textLayer.string = formattedString
        textLayer.bounds = CGRect(x: 0, y: 0, width: bounds.size.height - 10, height: bounds.size.width - 10)
        textLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        textLayer.shadowOpacity = 0.7
        textLayer.shadowOffset = CGSize(width: 2, height: 2)
        textLayer.foregroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0.0, 0.0, 0.0, 1.0])
        textLayer.contentsScale = 2.0 // retina rendering
        // rotate the layer into screen orientation and scale and mirror
        textLayer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 2.0)).scaledBy(x: 1.0, y: -1.0))
        return textLayer
    }
    
    func createRoundedRectLayerWithBounds(_ bounds: CGRect, color: UIColor) -> CAShapeLayer {
        
        if bounds.size.width > bounds.size.height {
            let radius: CGFloat = bounds.size.width / 2
            
            let increment = bounds.size.width / 2 - bounds.size.height / 2
           
            let path = UIBezierPath(roundedRect: CGRect(x: bounds.origin.x - 5, y: bounds.origin.y - 5 - increment, width: radius * 2 + 10, height: radius * 2 + 10), cornerRadius: radius + 5)
            let circlePath = UIBezierPath(roundedRect: CGRect(x: bounds.origin.x + 5, y: bounds.origin.y - increment + 5, width: radius * 2 - 10, height: radius * 2 - 10), cornerRadius: radius - 5)
//            print("originDele = \(circlePath.bounds.center)")
            path.append(circlePath)
            path.usesEvenOddFillRule = true

            let fillLayer = CAShapeLayer()
            fillLayer.path = path.cgPath
            fillLayer.fillRule = .evenOdd
            fillLayer.fillColor = color.cgColor
            fillLayer.opacity = 0.5
            
            return fillLayer
        } else {
            let radius: CGFloat = bounds.size.height / 2
            
            let increment = bounds.size.height / 2 - bounds.size.width / 2
            let path = UIBezierPath(roundedRect: CGRect(x: bounds.origin.x - 5 - increment, y: bounds.origin.y - 5, width: radius * 2 + 10, height: radius * 2 + 10), cornerRadius: radius + 5)
            let circlePath = UIBezierPath(roundedRect: CGRect(x: bounds.origin.x + 5 - increment, y: bounds.origin.y + 5, width: radius * 2 - 10, height: radius * 2 - 10), cornerRadius: radius - 5)
//            print("originDele = \(circlePath.bounds.center)")
            path.append(circlePath)
            path.usesEvenOddFillRule = true

            let fillLayer = CAShapeLayer()
            fillLayer.path = path.cgPath
            fillLayer.fillRule = .evenOdd
            fillLayer.fillColor = color.cgColor
            fillLayer.opacity = 0.5
            
            return fillLayer
        }
       
    }
    
    func dudesFunction(_ bounds: CGRect, color: UIColor) -> CGPoint {
        
        if bounds.size.width > bounds.size.height {
            let radius: CGFloat = bounds.size.width / 2
            
            let increment = bounds.size.width / 2 - bounds.size.height / 2
            let circlePath = UIBezierPath(roundedRect: CGRect(x: bounds.origin.x + 5, y: bounds.origin.y - increment + 5, width: radius * 2 - 10, height: radius * 2 - 10), cornerRadius: radius - 5)
            return CGPoint(x: circlePath.bounds.center.y , y: circlePath.bounds.center.x)
        } else {
            let radius: CGFloat = bounds.size.height / 2
            
            let increment = bounds.size.height / 2 - bounds.size.width / 2
            let circlePath = UIBezierPath(roundedRect: CGRect(x: bounds.origin.x + 5 - increment, y: bounds.origin.y + 5, width: radius * 2 - 10, height: radius * 2 - 10), cornerRadius: radius - 5)
            return CGPoint(x: circlePath.bounds.center.y , y: circlePath.bounds.center.x)
        }
       
    }
}

extension CGRect {
    var area: CGFloat {
        return self.height * self.width
    }
}
