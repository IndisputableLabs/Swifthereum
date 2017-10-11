#
# Be sure to run `pod lib lint Swifthereum.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Swifthereum'
  s.version          = '0.1.0'
  s.summary          = 'A native iOS and MacOS Swift wrapper for Geth (Go Ethereum).'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Swifthereum is a native Swift iOS and MacOS library to use Go Ethereum (Geth). Swifthereum wraps the Go interface into a Swift-friendly framework for easy and fast development of Swift-native dApps.

Swifthereum includes support for ERC-20 tokens and provides a download option to download a list of the latest tokens.
                       DESC

  s.homepage         = 'https://github.com/IndisputableLabs/Swifthereum'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors           = { 'Ronald Mannak' => 'ronald@indisputable.io' }
  s.source           = { :git => 'https://github.com/IndisputableLabs/Swifthereum.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ronaldmannak'

  s.ios.deployment_target = '9.0'
  #spec.osx.deployment_target  = '10.10'

  s.source_files = 'Swifthereum/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Swifthereum' => ['Swifthereum/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'BigInt', '~> 3.0.0'
  s.dependency 'Geth', '~> 1.7.1'
end
