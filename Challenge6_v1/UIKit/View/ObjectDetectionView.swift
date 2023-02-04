//
//  ObjectDetectionView.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 03/02/23.
//

import Foundation
import UIKit
import AVFoundation
import Vision

class ObjectDetectionView: UIView, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    
    private let session = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer! = nil
    var bufferSize: CGSize = .zero
    private let videoDataOutputQueue = DispatchQueue(label: "VideoDataOutput", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    let videoDataOutput = AVCaptureVideoDataOutput()
    var videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first
    var rootLayer: CALayer! = nil
    
    func setupAVCapture() {
        var deviceInput: AVCaptureDeviceInput!
      
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
            try videoDevice!.lockForConfiguration()
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
        rootLayer = self.layer
        rootLayer.bounds = self.bounds
        rootLayer.addSublayer(previewLayer)
    }
    
    func startCaptureSession() {
        DispatchQueue.global(qos: .userInteractive).async {[weak self] in
            self?.session.startRunning()
        }
        
    }
}
