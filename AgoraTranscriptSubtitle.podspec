Pod::Spec.new do |spec|
  spec.name         = "AgoraTranscriptSubtitle"
  spec.version      = "1.0.0"
  spec.summary      = "AgoraTranscriptSubtitle"
  spec.description  = "AgoraTranscriptSubtitle"

  spec.homepage     = "https://github.com/AgoraIO-Community"
  spec.license      = "MIT"
  spec.author       = { "ZYP" => "zhuyuping@shengwang.cn" }
  spec.source       = { :git => "https://github.com/AgoraIO-Community/TranscriptionWidget-iOS.git", :tag => '1.0.0' }
  spec.source_files  = ["*/Class/*.swift", "*/Class/Machine/*.swift", "*/Class/Other/**/*", "*/Class/Views/*", "*/Class/Models/*", "*/Class/Utils/*"]
  spec.public_header_files = "*/Class/**/*.h"
  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64', 'DEFINES_MODULE' => 'YES' }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64', 'DEFINES_MODULE' => 'YES' }
  spec.ios.deployment_target = '10.0'
  spec.swift_versions = "5.0"
  spec.requires_arc  = true
  spec.dependency 'AgoraComponetLog', "~> 0.0.3"
  spec.dependency 'Protobuf', '3.28.2'
  
  spec.subspec 'Machine' do |subspec|
    subspec.source_files = ["*/Class/Machine/*.swift", "*/Class/Other/**/*", "*/Class/Models/*", "*/Class/Utils/*"]
    subspec.test_spec 'Tests' do |test_spec|
      test_spec.source_files = "AgoraTranscriptSubtitle/Tests/**/*.{swift}"
      test_spec.resource = "AgoraTranscriptSubtitle/Tests/Resource/*"
      test_spec.frameworks = 'UIKit','Foundation'
      test_spec.requires_app_host = true
    end
  end
  
  spec.test_spec 'Tests' do |test_spec|
    test_spec.source_files = "AgoraTranscriptSubtitle/Tests/**/*.{swift}"
    test_spec.resource = "AgoraTranscriptSubtitle/Tests/Resource/*"
    test_spec.frameworks = 'UIKit','Foundation'
    test_spec.requires_app_host = true
  end
  
end
