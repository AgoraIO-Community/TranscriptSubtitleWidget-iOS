# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'AgoraRTT_Demo' do
  
  use_frameworks!

  # Agora
  pod 'AgoraRtcEngine_iOS', '4.2.6'
  # Protobuf
  pod "Protobuf", "3.21.12"
  # Progress
  pod 'SVProgressHUD'
  pod 'AgoraComponetLog'
  pod 'AgoraTranscriptSubtitle', :path => './AgoraTranscriptSubtitle.podspec', :testspecs => ['Tests']
end

target 'AgoraRTT_DemoTests' do
  use_frameworks!
  pod 'AgoraComponetLog'
end

