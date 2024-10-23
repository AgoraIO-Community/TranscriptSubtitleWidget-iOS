//
//  ViewController.m
//  AgoraRTT_Demo_Machine
//
//  Created by ZYP on 2024/10/23.
//

#import "ViewController.h"
#import "AgoraComponetDDLogFileLogger.h"
@import AgoraTranscriptSubtitle;
@import AgoraComponetLog;

@interface ViewController ()<TranscriptSubtitleMachineDelegate>
@property (nonatomic, strong) TranscriptSubtitleMachine *machine;
@property (nonatomic, strong) AgoraComponetLog *logger;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AgoraComponetConsoleLogger *fileLogger = [[AgoraComponetConsoleLogger alloc] initWithDomainName:@"ATS"];
    _machine = [[TranscriptSubtitleMachine alloc] initWithLoggers:@[fileLogger]];
    _machine.delegate = self;
}

- (void)transcriptSubtitleMachine:(TranscriptSubtitleMachine * _Nonnull)machine didAddRenderInfo:(RenderInfo * _Nonnull)renderInfo {
    
}

- (void)transcriptSubtitleMachine:(TranscriptSubtitleMachine * _Nonnull)machine didUpadteRenderInfo:(RenderInfo * _Nonnull)renderInfo {
    
}


@end
