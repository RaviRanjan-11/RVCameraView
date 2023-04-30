//
//  ViewController.swift
//  RVCameraView
//
//  Created by 26132769 on 04/29/2023.
//  Copyright (c) 2023 26132769. All rights reserved.
//

import UIKit
import RVCameraView
import AVKit

class ViewController: UIViewController, RVCameraImageOutputProtocol {
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var cameraTypeButton: UIButton!
    @IBOutlet weak var cameraOptionSegmentControl: UISegmentedControl!
    @IBOutlet weak var rvCameraView: RVCameraView!
    var camera: cameraType = .front
    var currentCameraType: CameraOptionType = .photo

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }

    
    private func configureUI(){
        self.cameraButton.layer.cornerRadius = self.cameraButton.frame.width / 2
        self.cameraButton.layer.borderColor = UIColor.black.cgColor
        self.cameraButton.layer.borderWidth = 2.0
    }
    override func viewDidAppear(_ animated: Bool) {
        self.rvCameraView.cameraImageOutputDelegate = self
        self.rvCameraView.cameraType = .front
        self.rvCameraView.cameraOutputType = .photo
        self.rvCameraView.initiliseRVCameraView()

    }
    @IBAction func onClickCameraButton(_ sender: UIButton) {
        self.rvCameraView.capture()
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
            print(photo as Any)
            guard let previewImage = photo else {
                print("Image not clicked")
                return
            }
            self.previewClickedImage(with: previewImage)
        
        case .video:
            print(videoURL as Any)
            
            guard let previewURL = videoURL else {
                print("Unable to create preview URL")
                return
            }
            self.setup(with: previewURL)

        }
    }

    
    func previewClickedImage(with image: UIImage) {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: self.view.center.x - 100, y: self.view.center.y - 100), size: CGSize(width: 200, height: 200)))
        imageView.image = image
        view.addSubview(imageView)
    }
    
    func setup(with videoURL: URL) {
        // Create the AVPlayer item
        let playerItem = AVPlayerItem(url: videoURL)
        
        // Create the AVPlayer
        let player = AVPlayer(playerItem: playerItem)
        
        // Create the AVPlayerLayer and add it to the view's layer
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        
        // Start playing the video
        player.play()
    }
   
}
