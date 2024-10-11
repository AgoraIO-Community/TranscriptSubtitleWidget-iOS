//
//  CustomFileLogger.m
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/10/9.
//

#import "AgoraComponetDDLogFileLogger.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
#import "AgoraDDLogFileManagerDefault.h"

static const DDLogLevel ddLogLevel = DDLogLevelAll;

@interface AgoraComponetDDLogFileLogger()
@property (nonatomic, strong)DDFileLogger *fileLogger;
@end

@implementation AgoraComponetDDLogFileLogger

- (instancetype)init {
    if (self = [super init]) {
        [DDLog addLogger:[DDOSLogger sharedInstance]];
        NSString *logDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        AgoraDDLogFileManagerDefault *logFileManager = [[AgoraDDLogFileManagerDefault alloc] initWithLogsDirectory:logDirectory fileName:@"agora.TranscriptSubtitle"];
        _fileLogger = [[DDFileLogger alloc] initWithLogFileManager:logFileManager];
        _fileLogger.rollingFrequency = 60 * 60 * 1;
        _fileLogger.maximumFileSize = 1024 * 1024 * 2;
        _fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
        [DDLog addLogger:_fileLogger];
    }
    return self;
}

- (void)onLogWithContent:(NSString *)content
                     tag:(NSString *)tag
                    time:(NSString *)time
                   level:(AgoraComponetLoggerLevel)level {
    NSString *domainName = @"ATS";
    NSString *text = tag == nil ? [NSString stringWithFormat:@"[%@]: %@", domainName, content] : [NSString stringWithFormat:@"[%@][%@]: %@", domainName, tag, content];
    
    switch (level) {
        case AgoraComponetLoggerLevelError:
            DDLogError(@"%@", text);
            break;
        case AgoraComponetLoggerLevelWarning:
            DDLogWarn(@"%@", text);
            break;
        case AgoraComponetLoggerLevelInfo:
            DDLogInfo(@"%@", text);
            break;
        case AgoraComponetLoggerLevelDebug:
            DDLogDebug(@"%@", text);
            break;
        default:
            DDLogVerbose(@"%@", text);
            break;
    }
}



@end
