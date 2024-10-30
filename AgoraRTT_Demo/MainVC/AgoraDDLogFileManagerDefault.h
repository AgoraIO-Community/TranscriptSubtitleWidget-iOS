//
//  AgoraDDLogFileManagerDefault.h
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/10/9.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgoraDDLogFileManagerDefault : DDLogFileManagerDefault
- (instancetype)initWithLogsDirectory:(NSString *)logsDirectory
                             fileName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
