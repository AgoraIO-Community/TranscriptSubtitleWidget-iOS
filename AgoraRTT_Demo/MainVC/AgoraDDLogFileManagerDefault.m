//
//  AgoraDDLogFileManagerDefault.m
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/10/9.
//

#import "AgoraDDLogFileManagerDefault.h"


@interface AgoraDDLogFileManagerDefault()
@property (nonatomic, strong)NSString *fileName;
@end

@implementation AgoraDDLogFileManagerDefault


#pragma mark - Lifecycle method

- (instancetype)initWithLogsDirectory:(NSString *)logsDirectory
                             fileName:(NSString *)name {
    self = [super initWithLogsDirectory:logsDirectory];
    if (self) {
        self.fileName = name;
    }
    return self;
}

#pragma mark - Override methods

- (NSString *)newLogFileName {
    //重写文件名称
    NSDateFormatter *dateFormatter = [self logFileDateFormatter];
    NSString *formattedDate = [dateFormatter stringFromDate:[NSDate date]];
    return [NSString stringWithFormat:@"%@-%@.log", self.fileName, formattedDate];
}

- (BOOL)isLogFile:(NSString *)fileName {
    BOOL hasProperPrefix = [fileName hasPrefix:[self.fileName stringByAppendingString:@"-"]];
    BOOL hasProperSuffix = [fileName hasSuffix:@".log"];
    BOOL isMyLogFile = (hasProperPrefix && hasProperSuffix);
    return isMyLogFile;
}

- (NSDateFormatter *)logFileDateFormatter {
    NSMutableDictionary *dictionary = [[NSThread currentThread]
                                       threadDictionary];
    NSString *dateFormat = @"yyyy'-'MM'-'dd'--'HH'-'mm'-'ss'-'SSS'";
    NSString *key = [NSString stringWithFormat:@"logFileDateFormatter.%@", dateFormat];
    NSDateFormatter *dateFormatter = dictionary[key];

    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
        [dateFormatter setDateFormat:dateFormat];
        dictionary[key] = dateFormatter;
    }

    return dateFormatter;
}
@end
