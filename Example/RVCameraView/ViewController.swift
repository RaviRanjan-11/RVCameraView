//
//  ViewController.swift
//  RVCameraView
//
//  Created by 26132769 on 04/29/2023.
//  Copyright (c) 2023 26132769. All rights reserved.
//

import UIKit
import RVCameraView

class ViewController: UIViewController, RVCameraImageOutputProtocol {
   
    @IBOutlet weak var cameraTypeButton: UIButton!
    @IBOutlet weak var cameraOptionSegmentControl: UISegmentedControl!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var rvCameraView: RVCameraView!
    var camera: cameraType = .front
    var currentCameraType: CameraOptionType = .photo

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func viewDidAppear(_ animated: Bool) {
        self.rvCameraView.cameraImageOutputDelegate = self
        self.rvCameraView.cameraType = .front
        self.rvCameraView.cameraOutputType = .photo
        self.rvCameraView.initiliseRVCameraView()

    }
    @IBAction func onClickCameraButton(_ sender: UIButton) {
        switch currentCameraType {
        case .photo:
            self.rvCameraView.captureImage()
        case .video:
            self.rvCameraView.captureImage()
        }
    }
    @IBAction func onTapCameraType(_ sender: UIButton) {
        switch camera {
        case .front:
            camera = .rear
            self.rvCameraView.cameraType = .back
            sender.setTitle("R", for: .normal)

        case .rear:
            camera = .front
            self.rvCameraView.cameraType = .front
            sender.setTitle("F", for: .normal)
        }
        
    }
    
    @IBAction func onChangeCameraType(_ sender: UISegmentedControl, forEvent event: UIEvent) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            self.currentCameraType = .photo
            self.rvCameraView.cameraOutputType = .photo

        case 1:
            self.currentCameraType = .video
            self.rvCameraView.cameraOutputType = .video

        default:
            self.currentCameraType = .photo
            self.rvCameraView.cameraOutputType = .photo
        }
    }
    
    func getCameraOutput(with photo: UIImage?, videoURL: URL?) {
        switch currentCameraType {
        case .photo:
            print(photo)
        case .video:
            print(videoURL)

        }
    }
   
}
