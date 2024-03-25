#
# Be sure to run `pod lib lint ZKJAIAlgoSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZKJAIAlgoSDK'
  s.version          = '1.4.0'
  s.summary          = 'A short description of ZKJAIAlgoSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/davien/ZKJAIAlgoSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'davien' => 'weiqiang.zhao@msxf.com' }
  s.source           = { :git => 'https://github.com/davien/ZKJAIAlgoSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '9.0'
  s.libraries  = "z", "c++"
  s.static_framework      = true
  
  # 仅支持真机的设置
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64 x86_64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64 x86_64' }
  
#  s.source_files = 'ZKJAIAlgoSDK/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZKJAIAlgoSDK' => ['ZKJAIAlgoSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

  s.subspec 'Core' do |ss|
    ss.source_files = 'ZKJAIAlgoSDK/Core/**/*'
    ss.public_header_files = 'ZKJAIAlgoSDK/Core/*.h'
  end
  
  s.subspec 'FaceCore' do |ss|
    ss.source_files = 'ZKJAIAlgoSDK/FaceCore/**/*'
    ss.public_header_files = 'ZKJAIAlgoSDK/FaceCore/*.h'
    ss.dependency 'ZKJAIAlgoSDK/Core'
  end
  
  s.subspec 'LiveCore' do |ss|
    ss.source_files = 'ZKJAIAlgoSDK/LiveCore/**/*'
    ss.public_header_files = 'ZKJAIAlgoSDK/LiveCore/*.h'
    ss.dependency 'ZKJAIAlgoSDK/Core'
  end
  
  s.subspec 'OCRCore' do |ss|
    ss.source_files = 'ZKJAIAlgoSDK/OCRCore/**/*'
    ss.public_header_files = 'ZKJAIAlgoSDK/OCRCore/*.h'
    ss.dependency 'ZKJAIAlgoSDK/Core'
  end

  s.subspec 'MSFaceKit' do |ss|
    ss.source_files = 'ZKJAIAlgoSDK/MSFaceKit/*.{h,m}'
    ss.public_header_files = 'ZKJAIAlgoSDK/MSFaceKit/*.h'
    ss.dependency 'ZKJAIAlgoSDK/FaceCore'
    ss.resources     = ['Bundle/LibActionLive.bundle']
    ss.vendored_frameworks = ['Framework/opencv2.framework','Framework/MSMNN.framework','Framework/LibActionLive.framework']
  end
  
  s.subspec 'MSLiveKit' do |ss|
    ss.source_files = 'ZKJAIAlgoSDK/MSLiveKit/*.{h,m}'
    ss.public_header_files = 'ZKJAIAlgoSDK/MSLiveKit/*.h'
    ss.dependency 'ZKJAIAlgoSDK/LiveCore'
    ss.resources     = ['Bundle/LibActionLive.bundle']
    ss.vendored_frameworks ='Framework/opencv2.framework','Framework/MSMNN.framework','Framework/LibActionLive.framework'
  end
  
  s.subspec 'MSOCRKit' do |ss|
    ss.source_files = 'ZKJAIAlgoSDK/MSOCRKit/*.{h,m}'
    ss.public_header_files = 'ZKJAIAlgoSDK/MSOCRKit/*.h'
    ss.dependency 'ZKJAIAlgoSDK/OCRCore'
    ss.resources     = ['Bundle/libidcardocr.bundle']
    ss.vendored_frameworks = ['Framework/opencv2.framework','Framework/MSMNN.framework','Framework/libidcardocr.framework']
  end
  
end
