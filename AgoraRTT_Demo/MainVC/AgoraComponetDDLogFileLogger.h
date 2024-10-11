//
//  CustomFileLogger.h
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/10/9.
//

#import <Foundation/Foundation.h>
@import AgoraComponetLog;

NS_ASSUME_NONNULL_BEGIN



@interface AgoraComponetDDLogFileLogger : NSObject<AgoraComponetLogger>

- (void)onLogWithContent:(NSString *)content
                     tag:(NSString * _Nullable)tag
                    time:(NSString *)time
                   level:(AgoraComponetLoggerLevel)level;

@end

NS_ASSUME_NONNULL_END
