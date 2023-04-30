# RVCameraView

[![Version](https://img.shields.io/cocoapods/v/RVCameraView.svg?style=flat)](https://cocoapods.org/pods/RVCameraView)
[![License](https://img.shields.io/cocoapods/l/RVCameraView.svg?style=flat)](https://cocoapods.org/pods/RVCameraView)
[![Platform](https://img.shields.io/cocoapods/p/RVCameraView.svg?style=flat)](https://cocoapods.org/pods/RVCameraView)

![RVCameraView](https://user-images.githubusercontent.com/26132769/235347367-d127cda3-3fc9-4bcb-a50f-8377ccf3e0a6.png)


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements


## Installation

RVCameraView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RVCameraView'
```

## How To Implement

    @IBOutlet weak var rvCameraView: RVCameraView!


    func loadCamera() {
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
## Author

Ravi, r.ranjanchn@gmail.com

## License

RVCameraView is available under the MIT license. See the LICENSE file for more info.
