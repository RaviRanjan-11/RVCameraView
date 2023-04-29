//
//  RVCameraViewProtocols.swift
//  RVCameraView
//
//  Created by Ravi Ranjan on 29/04/23.
//

import Foundation

protocol RVCameraProtocol {
    func initiliseRVCameraView()
    func capture()
    var cameraImageOutputDelegate: RVCameraImageOutputProtocol? { get set}
    
}

public protocol RVCameraImageOutputProtocol {
    func getCameraOutput(with photo: UIImage?, videoURL: URL?)
}
