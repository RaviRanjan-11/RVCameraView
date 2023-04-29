#
# Be sure to run `pod lib lint RVCameraView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RVCameraView'
  s.version          = '1.0.0'
  s.summary          = 'Custom Camera view with Photo capture and Video recording at same time with Front or rear camera '

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  'Custom Camera view with Photo capture and Video recording at same time with Front or rear camera '
  DESC

  s.homepage         = 'https://github.com/veerChauhan/RVCameraView.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '' => 'r.ranjanchn@gmail.com' }
  s.source           = { :git => 'https://github.com/veerChauhan/RVCameraView.git', :tag => s.version.to_s }
   s.social_media_url = 'https://twitter.com/b_banzara'

  s.ios.deployment_target = '13.0'

  s.source_files = 'Source/**/*'
  
  # s.resource_bundles = {
  #   'RVNetwork' => ['RVNetwork/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
