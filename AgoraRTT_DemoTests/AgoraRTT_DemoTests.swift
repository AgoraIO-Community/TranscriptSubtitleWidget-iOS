//
//  AgoraRTT_DemoTests.swift
//  AgoraRTT_DemoTests
//
//  Created by ZYP on 2024/6/21.
//

import XCTest

final class AgoraRTT_DemoTests: XCTestCase {
    let testInfo = HttpClient.TestServerInfo(ip: "218.205.37.49", port: 4447)
    
    override func setUpWithError() throws {
        Log.setupLogger()
    }

    func testHttpClient() throws {
        let exp = XCTestExpectation(description: "test acquire")
        
        var token: String? = nil
        HttpClient.acquire(appId: KeyCenter.appId,
                           instanceId: "44",
                           testServerInfo: testInfo,
                           timeoutInterval: 5) { buildToken, errorMsg in
            if buildToken != nil {
                token = buildToken
                exp.fulfill()
            }
            else {
                fatalError()
            }
        }
        wait(for: [exp], timeout: 6)
        
        guard let token = token else {
            fatalError()
        }
        
        let exp2 = XCTestExpectation(description: "test start")
        var taskId: String? = nil
        let rtcConfig = HttpClient.RtcConfig(channelName: "44", subBotUid: "998", pubBotUid: "999")
        HttpClient.start(appId: KeyCenter.appId,
                         token: token,
                         targetTranscribeLanguages: ["zh-CN"],
                         sourceTranslateLanguage: "zh-CN",
                         targetTranslateLanguages: ["en-US"],
                         rtcConfig: rtcConfig,
                         testServerInfo: testInfo,
                         timeoutInterval: 5) { id, errorMsg in
            if id != nil {
                taskId = id
                exp2.fulfill()
            }
            else {
                fatalError()
            }
        }
        
        wait(for: [exp2], timeout: 6)
        
        guard let taskId = taskId else {
            fatalError()
        }
        
        let exp3 = XCTestExpectation(description: "test stop")
        HttpClient.stop(appId: KeyCenter.appId,
                        token: token,
                        taskId: taskId,
                        timeoutInterval: 5) { errorMsg in
            if errorMsg == nil {
                exp3.fulfill()
            }
            else {
                fatalError()
            }
        }
        
        wait(for: [exp3], timeout: 6)
    }

}
