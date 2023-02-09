//
//  VisionDetectionView.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 04/02/23.
//

import Foundation
import Vision
import UIKit
import AVFoundation


class VisionDetectionView: CameraFeedView {
    
    
    weak var delegate: VisionResultsDelegate?
    var detectionOverlay: CALayer! = nil
//    var bufferSize: CGSize = .zero
    var requests = [VNRequest]()
    /*
     setupLayers()
     updateLayerGeometry()
     setupVision()
     */
    
//    func setBufferSize (_ bufferSize: CGSize){
//        self.bufferSize = bufferSize
//    }
//    
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
                        self.delegate?.updateStatusView(results.count)
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
    
    func switchCameraTapped() {
        //Change camera source
        //Indicate that some changes will be made to the session
        session.beginConfiguration()

        //Remove existing input
        guard let currentCameraInput: AVCaptureInput = session.inputs.first else {
            return
        }


        //Get new input
        var newCamera: AVCaptureDevice! = nil
        if let input = currentCameraInput as? AVCaptureDeviceInput {
            if (input.device.position == .back) {
                newCamera = cameraWithPosition(position: .front)
                self.previewLayer.transform = CATransform3DMakeRotation(.pi, 0, 1, 0);

                
                
            } else {
                newCamera = cameraWithPosition(position: .back)
                self.previewLayer.transform = CATransform3DMakeRotation(0, 0, 1, 0);
            }
        }

        //Add input to session
        var err: NSError?
        var newVideoInput: AVCaptureDeviceInput!
        do {
            newVideoInput = try AVCaptureDeviceInput(device: newCamera)
        } catch let err1 as NSError {
            err = err1
            newVideoInput = nil
        }

        if let inputs = session.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                session.removeInput(input)
            }
        }


        if newVideoInput == nil || err != nil {
            print("Error creating capture device input: \(err?.localizedDescription)")
        } else {
            session.addInput(newVideoInput)
        }

        //Commit all the configuration changes at once
        session.commitConfiguration()
    }

    
    
    func drawVisionRequestResults(_ results: [Any]) {
        CATransaction.begin()
        //MARK: resetting all objects
        detectionOverlay.sublayers = nil
//        filterResults(results: results)
        let biggestObject:VNRecognizedObjectObservation = getBiggestObject(results)
        //        if biggestObject.confidence > 0.96 {
        //                let averageFromArray = ballXCenterHistory.reduce(0 as CGFloat) { $0 + CGFloat($1) } / CGFloat(ballXCenterHistory.count)}
        
        let normalizedBoundingBox = biggestObject.boundingBox
        let objectBounds = VNImageRectForNormalizedRect(normalizedBoundingBox, Int(bufferSize.width), Int(bufferSize.height))
        self.delegate?.updateDirectionStatus(objectVerticalSize: objectBounds.height, currentHeight: objectBounds.midX, confidence: CGFloat(biggestObject.confidence))
        
        let shapeLayer = self.createRoundedRectLayerWithBounds(objectBounds, color: UIColor.yellow)
        detectionOverlay.addSublayer(shapeLayer)
        self.updateLayerGeometry()
        CATransaction.commit()
    }
    
    func filterResults(results: [Any]){
        
        for observation in results where observation is VNRecognizedObjectObservation{
            let object = observation as! VNRecognizedObjectObservation
            print(object.labels)
        }
        
    }
    
    
    func getBiggestObject(_ results: [Any]) -> VNRecognizedObjectObservation {
        
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
        
        return biggestObject
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
    
    func updateLayerGeometry() {
        let bounds = self.layer.bounds
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
    
    func setupLayers() {
        detectionOverlay = CALayer() // container layer that has all the renderings of the observations
        detectionOverlay.name = "DetectionOverlay"
        detectionOverlay.bounds = CGRect(x: 0.0,
                                         y: 0.0,
                                         width: bufferSize.width,
                                         height: bufferSize.height)
        detectionOverlay.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
      
        self.layer.addSublayer(detectionOverlay)
    }
}
