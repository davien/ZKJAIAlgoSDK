Pod::Spec.new do |s|
  s.name = "ZKJAIAlgoSDK"
  s.version = "1.5.0"
  s.summary = "A short description of ZKJAIAlgoSDK."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"davien"=>"weiqiang.zhao@msxf.com"}
  s.homepage = "https://github.com/davien/ZKJAIAlgoSDK"
  s.description = "TODO: Add long description of the pod here."
  s.libraries = ["z", "c++"]
  s.source = —embedded

  s.ios.deployment_target    = '12.0'
  s.ios.vendored_framework   = 'ios/ZKJAIAlgoSDK.framework'
end
