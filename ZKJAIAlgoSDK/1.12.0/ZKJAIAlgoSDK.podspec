#
# Be sure to run `pod lib lint ZKJAIAlgoSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZKJAIAlgoSDK'
  s.version          = '1.12.0'
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
#  s.static_framework      = true
  
  # 仅支持真机的设置
#  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64 x86_64' }
#  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64 x86_64' }
  
  # 确保库只编译为真机arm64和模拟器x86_64架构
#   s.pod_target_xcconfig = {
#     'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'armv7 armv7s arm64',
#     'EXCLUDED_ARCHS[sdk=iphoneos*]' => 'i386 x86_64 armv7 armv7s',
#     'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64',
#     'VALID_ARCHS[sdk=iphoneos*]' => 'arm64'
#   }
#   s.user_target_xcconfig = {
#     'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'armv7 armv7s arm64',
#     'EXCLUDED_ARCHS[sdk=iphoneos*]' => 'i386 x86_64 armv7 armv7s',
#     'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64',
#     'VALID_ARCHS[sdk=iphoneos*]' => 'arm64'
#   }

    s.pod_target_xcconfig = {
        # 'VALID_ARCHS' => 'arm64',
        'EXCLUDED_ARCHS[sdk=iphoneos*]' => 'armv7 armv7s',
        'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'armv7 armv7s arm64'
      }
      s.user_target_xcconfig = {
        # 'VALID_ARCHS' => 'arm64',
        'EXCLUDED_ARCHS[sdk=iphoneos*]' => 'armv7 armv7s',
        'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => "armv7 armv7s arm64"
      }
   
#  s.source_files = 'ZKJAIAlgoSDK/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZKJAIAlgoSDK' => ['ZKJAIAlgoSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
#  s.default_subspecs = 'Core', 'FaceCore', 'LiveCore', 'OCRCore', 'MSFaceKit', 'MSLiveKit', 'MSOCRKit'


  s.subspec 'Core' do |ss|
    ss.source_files = 'Sources/Core/**/*.{h,m,swift}'
    ss.public_header_files = 'Sources/Core/*.h'
  end
  
  s.subspec 'FaceCore' do |ss|
    ss.source_files = 'Sources/FaceCore/**/*.{h,m,swift}'
    ss.public_header_files = 'Sources/FaceCore/*.h'
    ss.dependency 'ZKJAIAlgoSDK/Core'
  end
  
  s.subspec 'LiveCore' do |ss|
    ss.source_files = 'Sources/LiveCore/**/*.{h,m,swift}'
    ss.public_header_files = 'Sources/LiveCore/*.h'
    ss.dependency 'ZKJAIAlgoSDK/Core'
  end
  
  s.subspec 'OCRCore' do |ss|
    ss.source_files = 'Sources/OCRCore/**/*.{h,m,swift}'
    ss.public_header_files = 'Sources/OCRCore/*.h'
    ss.dependency 'ZKJAIAlgoSDK/Core'
  end
  

  s.subspec 'MSMNN' do |ss|
    ss.vendored_frameworks = 'Framework/MSMNN.framework'
  end
  
  s.subspec 'opencv2' do |ss|
    ss.vendored_frameworks = 'Framework/opencv2.framework'
  end
  
  
  s.subspec 'MSLibActionLive' do |ss|
    ss.resource_bundles = {
        'LibActionLive' => ['Bundle/LibActionLive.bundle']
    }
    ss.vendored_frameworks = ['Framework/LibActionLive.framework']
    ss.dependency 'ZKJAIAlgoSDK/MSMNN'
    ss.dependency 'ZKJAIAlgoSDK/opencv2'
  end
  
  s.subspec 'MSLibidcardocr' do |ss|
    ss.resource_bundles = {
          'libidcardocr' => ['Bundle/libidcardocr.bundle']
    }
    ss.vendored_frameworks = ['Framework/libidcardocr.framework']
    ss.dependency 'ZKJAIAlgoSDK/MSMNN'
    ss.dependency 'ZKJAIAlgoSDK/opencv2'
  end

  s.subspec 'MSFaceKit' do |ss|
    ss.source_files = 'Sources/MSFaceKit/**/*.{h,m,swift}'
    ss.public_header_files = 'Sources/MSFaceKit/*.h'
    ss.dependency 'ZKJAIAlgoSDK/FaceCore'
#    ss.resources     = ['Bundle/LibActionLive.bundle']
    ss.dependency 'ZKJAIAlgoSDK/MSLibActionLive'
  end
  
  s.subspec 'MSLiveKit' do |ss|
    ss.source_files = 'Sources/MSLiveKit/**/*.{h,m,swift}'
    ss.public_header_files = 'Sources/MSLiveKit/*.h'
    ss.dependency 'ZKJAIAlgoSDK/LiveCore'
#    ss.resources     = ['Bundle/LibActionLive.bundle']
    ss.dependency 'ZKJAIAlgoSDK/MSLibActionLive'
  end
  
  s.subspec 'MSOCRKit' do |ss|
    ss.source_files = 'Sources/MSOCRKit/**/*.{h,m,swift}'
    ss.public_header_files = 'Sources/MSOCRKit/*.h'
    ss.dependency 'ZKJAIAlgoSDK/OCRCore'
    ss.dependency 'ZKJAIAlgoSDK/MSLibidcardocr'
#    ss.resources     = ['Bundle/libidcardocr.bundle']
#    ss.resource_bundles = {
#        'libidcardocr' => ['Bundle/libidcardocr.bundle']
#    }
#    ss.vendored_frameworks = ['Framework/opencv2.framework','Framework/MSMNN.framework','Framework/libidcardocr.framework']
  end
  
end
