//
//  ObjectiveCCodeVC.m
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/7/12.
//

#import "ObjectiveCCodeVC.h"
@import AgoraTranscriptSubtitle;

@interface ObjectiveCCodeVC ()
@property (nonatomic, strong) TranscriptSubtitleView *transcriptSubtitleView;
@end

@implementation ObjectiveCCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _transcriptSubtitleView = [[TranscriptSubtitleView alloc] initWithFrame:CGRectZero loggers:@[[FileLogger new], [ConsoleLogger new]]];
    [_transcriptSubtitleView pushMessageDataWithData:[NSData new] uid:0];
    [_transcriptSubtitleView clear];
    NSString *allTranscriptText = [_transcriptSubtitleView getAllTranscriptText];
    NSString *allTranslateText = [_transcriptSubtitleView getAllTranslateText];
}

@end
