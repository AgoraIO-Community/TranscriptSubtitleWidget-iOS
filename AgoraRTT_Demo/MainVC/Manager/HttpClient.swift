//
//  HttpClient.swift
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/6/21.
//

import Foundation
import URLRequest_cURL

class HttpClient: NSObject {
    static let logTag = "HttpClient"
    typealias AcquireCompletedBlock = (_ token: String?, _ errorMsg: String?) -> Void
    
    static func acquire(appId: String,
                        auth: String?,
                        baseUrl: String,
                        instanceId: String,
                        testServerInfo: TestServerInfo?,
                        timeoutInterval: TimeInterval = 60,
                        completed: @escaping AcquireCompletedBlock) {
        let url = URL(string: baseUrl + "/v1/projects/" + appId + "/rtsc/speech-to-text/builderTokens")!
        
        var bodyDict : [String : Any] = ["instanceId" : instanceId,
                                         "devicePlatform" : "iOS"]
        if let testInfo = testServerInfo {
            bodyDict["testIp"] = testInfo.ip
            bodyDict["testPort"] = testInfo.port
        }
        let jsonBody = try! JSONSerialization.data(withJSONObject: bodyDict, options: [])
        
        var request = URLRequest(url: url)
        request.httpBody = jsonBody
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let auth = auth {
            request.setValue("agora token=\"\(auth)\"", forHTTPHeaderField: "Authorization")
        }
        request.timeoutInterval = timeoutInterval
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                Log.error(error: "Failed to acquire token: \(error.localizedDescription)", tag: logTag)
                completed(nil, error.localizedDescription)
            } else if let data = data {
                /// 把data转成dict
                let respDict = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                guard let token = respDict["tokenName"] as? String else {
                    Log.errorText(text: "resp: \(respDict)", tag: logTag)
                    completed(nil, "Failed to acquire token, can not find token in response")
                    return
                }
                
                completed(token, nil)
            }
        }
        
        task.resume()
    }
    
    typealias StartCompletedBlock = (_ taskId: String?, _ errorMsg: String?) -> Void
    static func start(appId: String,
                      auth: String?,
                      baseUrl: String,
                      token: String,
                      targetTranscribeLanguages: [String],
                      sourceTranslateLanguage: String,
                      targetTranslateLanguages: [String],
                      rtcConfig: RtcConfig,
                      testServerInfo: TestServerInfo?,
                      timeoutInterval: TimeInterval = 60,
                      completed: @escaping StartCompletedBlock) {
        let urlString = baseUrl + "/v1/projects/" + appId + "/rtsc/speech-to-text/tasks" + "?builderToken=" + token
        let url = URL(string: urlString)!
        
        let bodyDict: [String: Any] = [
            /// 需要识别的转录语种，最多支持两种语言
            "languages": targetTranscribeLanguages,
            "translateConfig": [
                "languages": [
                    [
                        "target": targetTranslateLanguages,
                        "source": sourceTranslateLanguage
                    ] as [String : Any]
                ]
            ],
            "maxIdleTime": 60,
            "devicePlatform": "iOS",
            "rtcConfig": [
                "channelName": rtcConfig.channelName,
                "subBotUid": rtcConfig.subBotUid,
                "pubBotUid": rtcConfig.pubBotUid
            ]
        ]
        let jsonBody = try! JSONSerialization.data(withJSONObject: bodyDict, options: [])
        
        var request = URLRequest(url: url)
        request.httpBody = jsonBody
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let auth = auth {
            request.setValue("agora token=\"\(auth)\"", forHTTPHeaderField: "Authorization")
        }
        request.timeoutInterval = timeoutInterval
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                Log.error(error: "Failed to start: \(error.localizedDescription)", tag: logTag)
                completed(nil, error.localizedDescription)
            } else if let data = data {
                let respDict = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                if let status = respDict["status"] as? String,
                   status == "STARTED",
                   let taskId = respDict["taskId"] as? String {
                    completed(taskId, nil)
                }
                else {
                    let jsonString = String(data: data, encoding: .utf8)!
                    Log.errorText(text: "start fail: \(jsonString)")
                    completed(nil, jsonString)
                }
            }
        }
        task.resume()
    }
    
    typealias StopCompletedBlock = (_ errorMsg: String?) -> Void
    static func stop(appId: String,
                     auth: String?,
                     baseUrl: String,
                     token: String,
                     taskId: String,
                     timeoutInterval: TimeInterval = 60,
                     completed: @escaping StopCompletedBlock) {
        let urlString = baseUrl + "/v1/projects/" + appId + "/rtsc/speech-to-text/tasks/\(taskId)" + "?builderToken=" + token
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let auth = auth {
            request.setValue("agora token=\"\(auth)\"", forHTTPHeaderField: "Authorization")
        }
        request.timeoutInterval = timeoutInterval
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                Log.error(error: "Failed to stop: \(error.localizedDescription)", tag: logTag)
                completed(error.localizedDescription)
            } else if let data = data {
                let respDict = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                if respDict.keys.isEmpty {
                    completed(nil)
                }
                else {
                    let jsonString = String(data: data, encoding: .utf8)!
                    Log.errorText(text: "stop fail: \(jsonString)")
                    completed(jsonString)
                }
            }
        }
        task.resume()
    }
}

extension HttpClient {
    struct TestServerInfo {
        let ip: String
        let port: UInt
    }
    
    struct RtcConfig {
        let channelName: String
        let subBotUid: String
        let pubBotUid: String
    }
}
