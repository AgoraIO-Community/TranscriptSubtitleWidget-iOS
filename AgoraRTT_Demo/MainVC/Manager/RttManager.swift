//
//  RttManager.swift
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/6/21.
//

import UIKit

protocol RttManagerDelegate: NSObjectProtocol {
    func rttManager(_ rttManager: RttManager, didOccurErrorWith msg: String)
    func rttManager(_ rttManager: RttManager, didStartWith taskId: String, token: String)
    func rttManagerDidStop(_ rttManager: RttManager)
}

class RttManager: NSObject {
    private let logTag = "RttManager"
    weak var delegate: RttManagerDelegate?
    
    func requestStartRttRecognize(channelId: String) {
        Log.debug(text: "current env: \(AppConfig.share.serverEnv.name)", tag: logTag)
        let testInfo: HttpClient.TestServerInfo? = AppConfig.share.serverEnv.testIp.isEmpty ? nil : HttpClient.TestServerInfo(ip: AppConfig.share.serverEnv.testIp, port: UInt(AppConfig.share.serverEnv.testPort))
        let targetTranscribeLanguages = AppConfig.share.transcriptLangs.map({ $0.rawValue })
        let sourceTranslateLanguage = targetTranscribeLanguages.first!
        let targetTranslateLanguages = AppConfig.share.translateLangs.map({ $0.rawValue })
        HttpClient.acquire(appId: AppConfig.share.serverEnv.appId,
                           auth: AppConfig.share.serverEnv.auth,
                           baseUrl: AppConfig.share.serverEnv.serverUrlString,
                           instanceId: channelId,
                           testServerInfo: testInfo) { [weak self](token, errorMsg) in
            guard let self = self else {
                return
            }
            if let errorMsg = errorMsg {
                let logText = "acquire rtt server fail: \(errorMsg)"
                Log.errorText(text: logText, tag: self.logTag)
                self.delegate?.rttManager(self, didOccurErrorWith: logText)
                return
            }
            
            let rtcConfig = HttpClient.RtcConfig(channelName: channelId,
                                                 subBotUid: "998",
                                                 pubBotUid: "999")
            HttpClient.start(appId: AppConfig.share.serverEnv.appId,
                             auth: AppConfig.share.serverEnv.auth,
                             baseUrl: AppConfig.share.serverEnv.serverUrlString,
                             token: token!,
                             targetTranscribeLanguages: targetTranscribeLanguages,
                             sourceTranslateLanguage: sourceTranslateLanguage,
                             targetTranslateLanguages: targetTranslateLanguages,
                             rtcConfig: rtcConfig,
                             testServerInfo: testInfo,
                             timeoutInterval: 15) { taskId, errorMsg in
                if let errorMsg = errorMsg {
                    let logText = "start rtt server fail: \(errorMsg)"
                    Log.errorText(text: logText, tag: self.logTag)
                    self.delegate?.rttManager(self, didOccurErrorWith: logText)
                    return
                }
                
                let logText = "start rtt server success, taskId: \(taskId!)"
                Log.info(text: logText, tag: self.logTag)
                
                self.delegate?.rttManager(self, didStartWith: taskId!, token: token!)
            }
        }
    }
    
    func requestStopRttRecognize(token: String, taskId: String) {
        HttpClient.stop(appId: AppConfig.share.serverEnv.appId,
                        auth: AppConfig.share.serverEnv.auth,
                        baseUrl: AppConfig.share.serverEnv.serverUrlString,
                        token: token,
                        taskId: taskId,
                        timeoutInterval: 10) { [weak self](errorMsg) in
            guard let self = self else { return }
            if let errorMsg = errorMsg {
                let logText = "stop rtt server fail: \(errorMsg)"
                Log.errorText(text: logText, tag: self.logTag)
                self.delegate?.rttManager(self, didOccurErrorWith: logText)
                return
            }
            
            let logText = "stop rtt server success"
            Log.info(text: logText, tag: self.logTag)
            
            self.delegate?.rttManagerDidStop(self)
        }
    }
}
