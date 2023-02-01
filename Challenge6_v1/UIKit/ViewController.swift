//
//  ViewController.swift
//  Object Detection Live Stream
//
//  Created by Alexey Korotkov on 6/25/19.
//  Copyright © 2019 Alexey Korotkov. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    let vibration = UISelectionFeedbackGenerator()
    var bufferSize: CGSize = .zero
    var rootLayer: CALayer! = nil
    var direction: Direction = .stopped
    @IBOutlet weak private var previewView: UIView!
    private let session = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer! = nil
    private let videoDataOutput = AVCaptureVideoDataOutput()
    
    var videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first
    
    
    var ballLabel: UIView = {
        let ballLabel = UIView()
        ballLabel.layer.borderWidth = 10
        ballLabel.layer.borderColor = CGColor(red: 255, green: 255, blue: 0, alpha: 0.7)
        ballLabel.isUserInteractionEnabled = false
        return ballLabel
    }()
    
    let switchCamera = UIButton()
    let directionLabel = UILabel()
    let viewOnTop = UIView()
    let startButton = UIButton()
    let targetScoreView: UILabel = {
        let targetScore = UILabel()
        targetScore.layer.cornerRadius = 20
        targetScore.layer.masksToBounds = true
        targetScore.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        targetScore.frame = CGRect(x: 40, y: 40, width: 120, height: 60)
        targetScore.textColor = .black
        targetScore.text = "Target: 0"
        targetScore.textAlignment = .center
        return targetScore
    }()
    
    var pointCounter: KeepyUpCounterView = KeepyUpCounterView()
    var resetButton: UIButton = {
        let resetButton = UIButton()
        resetButton.layer.cornerRadius = 20
        resetButton.layer.masksToBounds = true
        resetButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        resetButton.titleLabel?.textAlignment = .center
        resetButton.setTitle("Reset Score", for: .normal)
        resetButton.setTitleColor(.black, for: .normal)
        resetButton.frame = CGRect(x: 20, y: UIScreen.screens.first!.bounds.size.height - 100, width: UIScreen.screens.first!.bounds.size.width - 30, height: 60)
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        return resetButton
    }()
  
    var numberOfKeepyUps = 0
    var targetScore = 10
    var timer = Timer()
    var miliseconds = 0
    
    var ballXCenterHistory = [CGFloat]()
    
    private let videoDataOutputQueue = DispatchQueue(label: "VideoDataOutput", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // to be implemented in the subclass
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupAVCapture()
        
        
        
        var panGesture = UIPanGestureRecognizer()
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.draggedView(_:)))
        pointCounter.addRecognizer(panGesture, label: pointCounter.hitbox)
        
        directionLabel.layer.cornerRadius = 20
        directionLabel.layer.masksToBounds = true
        directionLabel.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        directionLabel.frame = CGRect(x: UIScreen.screens.first!.bounds.size.width - 140, y: 40, width: 120, height: 60)
        directionLabel.textColor = .black
        directionLabel.textAlignment = .center
        directionLabel.text = direction.rawValue.capitalized
        
        switchCamera.layer.cornerRadius = 20
        switchCamera.layer.masksToBounds = true
        switchCamera.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        switchCamera.frame = CGRect(x: UIScreen.screens.first!.bounds.size.width/2 - 30, y: 40, width: 60, height: 60)
        switchCamera.imageView?.image = UIImage(systemName: "arrow.triangle.2.circlepath.camera.fill")?.withTintColor(.black, renderingMode: .alwaysTemplate)
        switchCamera.addTarget(self, action: #selector(switchCameraAction), for: .touchUpInside)
        
        targetScoreView.text = "Target: \(targetScore)"
        
        miliseconds = 0
        setupAVCapture()
        pointCounter.centerViews()
        self.view.addSubview(resetButton)
        for circle in pointCounter.circles{
            self.view.addSubview(circle)
        }
        
        self.view.addSubview(directionLabel)
        self.view.addSubview(targetScoreView)
        self.view.addSubview(ballLabel)


        ballXCenterHistory = [CGFloat]()
     
    }
    
    @objc func resetButtonPressed() {
        numberOfKeepyUps = 0
        pointCounter.pointCounterView.text = "0"
        miliseconds = 0
        pointCounter.bounceAnimation()
        pointCounter.paintBalls(color: .whiteCircle)
    }
    
    @objc func switchCameraAction() {
        videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: (videoDevice?.position == .front) ? .back : .front).devices.first
        rootLayer.sublayers?.removeAll()
        setupAVCapture()
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        self.view.bringSubviewToFront(pointCounter.hitbox)
        let translation = sender.translation(in: self.view)
        vibration.selectionChanged()
        pointCounter.repositionViews(point: pointCounter.outerCircle.center, translation: translation)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func setupAVCapture() {
        var deviceInput: AVCaptureDeviceInput!
        
        // Select a video device, make an input
       

        do {
        
            deviceInput = try AVCaptureDeviceInput(device: videoDevice!)
        } catch {
            print("Could not create video device input: \(error)")
            return
        }
        
        session.beginConfiguration()
        session.sessionPreset = .vga640x480 // Model image size is smaller.
        
        // Add a video input
        guard session.canAddInput(deviceInput) else {
            print("Could not add video device input to the session")
            session.commitConfiguration()
            return
        }
        session.addInput(deviceInput)
        if session.canAddOutput(videoDataOutput) {
            session.addOutput(videoDataOutput)
            // Add a video data output
            videoDataOutput.alwaysDiscardsLateVideoFrames = true
            videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
            
        } else {
            print("Could not add video data output to the session")
            session.commitConfiguration()
            return
        }
        let captureConnection = videoDataOutput.connection(with: .video)
        // Always process the frames
        captureConnection?.isEnabled = true
        do {
            try  videoDevice!.lockForConfiguration()
            let dimensions = CMVideoFormatDescriptionGetDimensions((videoDevice?.activeFormat.formatDescription)!)
            bufferSize.width = CGFloat(dimensions.width)
            bufferSize.height = CGFloat(dimensions.height)
            videoDevice!.unlockForConfiguration()
        } catch {
            print(error)
        }
        session.commitConfiguration()
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        rootLayer = previewView.layer
        previewLayer.frame = rootLayer.bounds
        rootLayer.addSublayer(previewLayer)
    }
    
    func startCaptureSession() {
        DispatchQueue.global(qos: .userInteractive).async {[weak self] in
            self?.session.startRunning()
        }
        
    }
    
    // Clean up capture setup
    func teardownAVCapture() {
        previewLayer.removeFromSuperlayer()
        previewLayer = nil
    }
    
    public func exifOrientationFromDeviceOrientation() -> CGImagePropertyOrientation {
        let curDeviceOrientation = UIDevice.current.orientation
        let exifOrientation: CGImagePropertyOrientation
        
        switch curDeviceOrientation {
        case UIDeviceOrientation.portraitUpsideDown:  // Device oriented vertically, home button on the top
            exifOrientation = .left
        case UIDeviceOrientation.landscapeLeft:       // Device oriented horizontally, home button on the right
            exifOrientation = .upMirrored
        case UIDeviceOrientation.landscapeRight:      // Device oriented horizontally, home button on the left
            exifOrientation = .down
        case UIDeviceOrientation.portrait:            // Device oriented vertically, home button on the bottom
            exifOrientation = .up
        default:
            exifOrientation = .up
        }
        return exifOrientation
    }
}


