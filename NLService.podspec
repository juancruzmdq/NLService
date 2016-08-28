#
# Be sure to run `pod lib lint NLService.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NLService'
  s.version          = '0.1.0'
  s.summary          = 'Network Layer Service.'

  s.description      = <<-DESC
Simple Networking layer over Alamofire
                       DESC

  s.homepage         = 'https://github.com/juancruzmdq/NLService'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Juan Cruz Ghigliani' => 'juancruzmdq@gmail.com' }
  s.source           = { :git => 'https://github.com/juancruzmdq/NLService.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/juancruzmdq'

  s.ios.deployment_target = '8.0'

  s.source_files = 'NLService/Classes/**/*'
  
  # s.resource_bundles = {
  #   'NLService' => ['NLService/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Ono'
  s.dependency 'Alamofire'

end
