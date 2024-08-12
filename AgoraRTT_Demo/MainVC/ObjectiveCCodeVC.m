//
//  ObjectiveCCodeVC.m
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/7/12.
//

#import "ObjectiveCCodeVC.h"
@import AgoraTranscriptSubtitle;
@import AgoraComponetLog;

@interface ObjectiveCCodeVC ()
@property (nonatomic, strong) TranscriptSubtitleView *transcriptSubtitleView;
@end

@implementation ObjectiveCCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    AgoraComponetFileLogger *fileLogger = [[AgoraComponetFileLogger alloc] initWithLogFilePath:nil
                                          filePrefixName:@"agora.AgoraTranscriptSubtitle"
                                      maxFileSizeOfBytes:1024 * 1024
                                            maxFileCount:4
                                              domainName:@"ATS"];
    AgoraComponetConsoleLogger *consoleLogger = [[AgoraComponetConsoleLogger alloc] initWithDomainName:@"ATS"];
    _transcriptSubtitleView = [[TranscriptSubtitleView alloc] initWithFrame:CGRectZero loggers:@[fileLogger, consoleLogger]];
    [_transcriptSubtitleView pushMessageDataWithData:[NSData new] uid:0];
    [_transcriptSubtitleView clear];
    NSString *allTranscriptText = [_transcriptSubtitleView getAllTranscriptText];
    NSString *allTranslateText = [_transcriptSubtitleView getAllTranslateText];
}

@end
