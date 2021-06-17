#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint scanovateplugin.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'adotech_puntopay'
  s.version          = '1.0.0'
  s.summary          = 'Scanovate plugin for flutter'
  s.description      = <<-DESC
Scanovate plugin for flutter
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'Socket.IO-Client-Swift', '15.2.0'
  s.dependency 'Alamofire', '4.8.2'
  s.dependency 'SheetyColors'	
  s.platform = :ios, '11.0'
  s.vendored_frameworks = 'ScanovateHybridLiveness.xcframework', 'ScanovateManualCapture.xcframework', 'SMSDK.xcframework'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework ScanovateHybridLiveness' }
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework ScanovateManualCapture' }
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework SMSDK' }


  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
