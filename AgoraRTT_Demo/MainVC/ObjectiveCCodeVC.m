//
//  ObjectiveCCodeVC.m
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/7/12.
//

#import "ObjectiveCCodeVC.h"
#import "AgoraComponetDDLogFileLogger.h"
@import AgoraTranscriptSubtitle;
@import AgoraComponetLog;

@interface ObjectiveCCodeVC ()<TranscriptSubtitleMachineDelegate>
@property (nonatomic, strong) TranscriptSubtitleView *transcriptSubtitleView;
@property (nonatomic, strong) TranscriptSubtitleMachine *machine;
@property (nonatomic, strong) AgoraComponetLog *logger;
@end

@implementation ObjectiveCCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    AgoraComponetFileLogger *fileLogger = [[AgoraComponetFileLogger alloc] initWithLogFilePath:nil
//                                                                                filePrefixName:@"testForLog"
//                                                                            maxFileSizeOfBytes:1024 * 1024 * 1
//                                                                                  maxFileCount:4
//                                                                                    domainName:@"ATS"];
    
//    AgoraComponetDDLogFileLogger *myFileLogger = [AgoraComponetDDLogFileLogger new];
    
//    AgoraComponetConsoleLogger *consoleLogger = [[AgoraComponetConsoleLogger alloc] initWithDomainName:@"ATS"];
//    _logger = [[AgoraComponetLog alloc] initWithQueueTag:@"agora.testForLog"];
//    [_logger configLoggers:@[myFileLogger]];
//
//
//    for (int i = 0; i < 100; i++) {
//        [_logger infoWithText:@"1234" tag:@"logtag"];
//    }
    
//    [_logger infoWithText:@"123" tag:@"logtag"];
    
//    TranscriptSubtitleMachine *m = [[TranscriptSubtitleMachine alloc] initWithLoggers:@[fileLogger, consoleLogger]];
//    m.delegate = self;
//
//    _transcriptSubtitleView = [[TranscriptSubtitleView alloc] initWithFrame:CGRectZero loggers:@[fileLogger, consoleLogger]];
//    [_transcriptSubtitleView pushMessageDataWithData:[NSData new] uid:0];
//    [_transcriptSubtitleView clear];
//    NSString *allTranscriptText = [_transcriptSubtitleView getAllTranscriptText];
//    NSString *allTranslateText = [_transcriptSubtitleView getAllTranslateText];
    
    AgoraComponetConsoleLogger *fileLogger = [[AgoraComponetConsoleLogger alloc] initWithDomainName:@"ATS"];
    _machine = [[TranscriptSubtitleMachine alloc] initWithLoggers:@[fileLogger]];
    _machine.delegate = self;
}

- (void)transcriptSubtitleMachine:(TranscriptSubtitleMachine * _Nonnull)machine didAddRenderInfo:(RenderInfo * _Nonnull)renderInfo {
    
}

- (void)transcriptSubtitleMachine:(TranscriptSubtitleMachine * _Nonnull)machine didUpadteRenderInfo:(RenderInfo * _Nonnull)renderInfo {
    
}

@end
