//
//  RVCameraView.swift
//  RVCameraView
//
//  Created by Ravi Ranjan on 29/04/23.
//
import Foundation
import UIKit
import AVFoundation


protocol RVCameraProtocol {
    func initiliseRVCameraView()
    func captureImage()
    var cameraImageOutputDelegate: RVCameraImageOutputProtocol? { get set}
    
}

public protocol RVCameraImageOutputProtocol {
    func getCameraOutput(with photo: UIImage?, videoURL: URL?)
}
final public class RVCameraView: UIView, RVCameraProtocol {
    
    let captureSession = AVCaptureSession()
    let rvCameraViewQueue = DispatchQueue(label: "com.rvcameraView.queue",attributes: .concurrent,autoreleaseFrequency: .inherit,target: .global())
    let capturePhotoOutput = AVCapturePhotoOutput()
    public var cameraImageOutputDelegate: RVCameraImageOutputProtocol?
    public var cameraType: RVCameraType? {
        didSet {
            self.addCameraInput()
        }
    }
    public var cameraOutputType: RVCameraOutputType?  {
        didSet {
            self.configureOutPut()
        }
    }
    let movieOutput = AVCaptureMovieFileOutput()

    var isRecordingStarted: Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    fileprivate func cameraPhotoOutput() {
        if captureSession.canAddOutput(capturePhotoOutput) {
            captureSession.addOutput(capturePhotoOutput)
        }
    }
    
    private func cameraVideoOutput() {
        if captureSession.canAddOutput(movieOutput) {
            captureSession.addOutput(movieOutput)
        }
    }
    
    public func initiliseRVCameraView() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
       
        self.addCameraInput()
        self.configureOutPut()
        self.addRVCameraViewPreviewLayer()
    }
    
    
    public func configureOutPut() {
        switch cameraOutputType {
        case .photo:
            self.cameraPhotoOutput()
        case .video:
            self.cameraVideoOutput()
        case .none:
            self.cameraPhotoOutput()
        }
    }
    
    private func addCameraInput() {
        
        if let inputToRemove = captureSession.inputs.first(where: { $0 is AVCaptureDeviceInput }) as? AVCaptureDeviceInput {
            captureSession.removeInput(inputToRemove)
        }

        var captureInputDevice : AVCaptureDevice?
        switch cameraType {
        case .front:
            let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            captureInputDevice = frontCamera
            
        case .back:
            let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            captureInputDevice = frontCamera
            
        case .none:
            let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            captureInputDevice = frontCamera

        }
        
        guard let captureInputDevice = captureInputDevice else {
            print("Unable to create capture device type ", cameraType?.cameraDeviceDescription as Any)
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureInputDevice)
            captureSession.addInput(input)
        } catch let error {
            print("Error creating AVCaptureDeviceInput: \(error.localizedDescription)")
        }
    }
    
    
    private func addRVCameraViewPreviewLayer() {
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = self.bounds
        self.layer.addSublayer(previewLayer)
        self.startRVCameraSession()
        
    }
    
    private func startRVCameraSession() {
        rvCameraViewQueue.async {
            self.captureSession.startRunning()
        }
    }
    
}
