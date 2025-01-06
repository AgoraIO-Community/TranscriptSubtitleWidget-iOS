# TranscriptionWidget-iOS


=======
## 字幕组件

### 介绍

字幕组件能够解析由 **声网的转写/翻译服务** 生成的结果，并将这些结果渲染在视图上，以实现类似同声传译的字幕展示效果。

### 集成方式

### Coaoapod 集成

```ruby
pod 'AgoraTranscriptSubtitle', ‘1.0.0’
```



### 使用步骤

#### 1. 导入

```swift
import AgoraTranscriptSubtitle
```

#### 2.初始化

```swift
let rect = CGRectMake(0, 0, 300, 400)
let rttView = TranscriptSubtitleView(frame: rect)
view.addSubview(rttView)
```

#### 3.push 数据

```swift
rttView.pushMessageData(data: data)
```

以上`data`是 protocol buffer 格式的二进制数据。 它通常来自 Agora rtc sdk 的回调: `receiveStreamMessageFromUid`

#### 4.清屏（如果需要）

```swift
rttView.clear()
```



### 日志记录

日志作为问题排查的最好方式，**建议在开发、测试打开**，在出现异常时方便排查。

#### 1.默认日志

在初始化`TranscriptSubtitleView`时，第二个参数 loggers 如果不传入，则使用默认日志记录。

#### 2. 自定义日志

字幕组件依赖了`AgoraComponetLog`框架，可以继承于`AgoraComponetLogger`协议写一个自定义的类。（可参考`AgoraComponetConsoleLogger.h`或`AgoraComponetFileLogger.h`）

```objective-c
@interface YourCustomLogger : NSObject <AgoraComponetLogger>
- (instancetype)initWithDomainName:(NSString *)domainName;
- (void)onLogWithContent:(NSString *)content
                     tag:(NSString * _Nullable)tag
                    time:(NSString *)time
                   level:(AgoraComponetLoggerLevel)level;
@end
```

实现后，在初始化`TranscriptSubtitleView`传入作为 loggers 参数：

```swift
let customLogger = YourCustomLogger(domainName: "ATS")
let rttView = TranscriptSubtitleView(frame: rect, loggers: [customLogger])
```








