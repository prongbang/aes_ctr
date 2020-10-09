#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint aes_ctr.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'aes_ctr'
  s.version          = '1.0.0'
  s.summary          = 'AES CTR - Counter Flutter plugin.'
  s.description      = <<-DESC
AES CTR - Counter Flutter plugin.
                       DESC
  s.homepage         = 'https://github.com/prongbang/aes_ctr'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'prongbang' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'CryptoSwift'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
