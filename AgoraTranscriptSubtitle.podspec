Pod::Spec.new do |spec|
  spec.name         = "AgoraTranscriptSubtitle"
  spec.version      = "0.0.3"
  spec.summary      = "AgoraTranscriptSubtitle"
  spec.description  = "AgoraTranscriptSubtitle"

  spec.homepage     = "https://github.com/AgoraIO-Community"
  spec.license      = "MIT"
  spec.author       = { "ZYP" => "zhuyuping@shengwang.cn" }
  spec.source       = { :git => "https://github.com/AgoraIO-Community/TranscriptionWidget-iOS.git", :tag => '0.0.3' }
  spec.source_files  = ["*/Class/**/*.{swift,h,m}"]
  spec.public_header_files = "*/Class/**/*.h"
  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64', 'DEFINES_MODULE' => 'YES' }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64', 'DEFINES_MODULE' => 'YES' }
  spec.ios.deployment_target = '10.0'
  spec.swift_versions = "5.0"
  spec.requires_arc  = true
  spec.dependency 'AgoraComponetLog', "~> 0.0.3"
  spec.dependency 'Protobuf', '3.21.12'
  
  spec.test_spec 'Tests' do |test_spec|
    test_spec.source_files = "AgoraTranscriptSubtitle/Tests/**/*.{swift}"
    test_spec.resource = "AgoraTranscriptSubtitle/Tests/Resource/*"
    test_spec.frameworks = 'UIKit','Foundation'
    test_spec.requires_app_host = true
  end
  
end
