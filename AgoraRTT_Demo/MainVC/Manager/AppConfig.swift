//
//  AppConfig.swift
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/7/9.
//

import Foundation

class AppConfig {
    static let share = AppConfig()
    
    var serverEnv = KeyCenter.serverEnvs.first!
    
    var transcriptLangs: [AgoraLanguage] = [.chinese]
    var translateLangs: [AgoraLanguage] = [.english]
    
    func updateByConfig(appConfig: AppConfig) {
        serverEnv = appConfig.serverEnv
        transcriptLangs = appConfig.transcriptLangs
        translateLangs = appConfig.translateLangs
    }
    
    func copyThis() -> AppConfig {
        let config = AppConfig()
        config.serverEnv = serverEnv
        config.transcriptLangs = transcriptLangs
        config.translateLangs = translateLangs
        return config
    }
}

class ServerEnv {
    var name: String
    var serverUrlString: String
    var testIp: String
    var testPort: UInt
    
    init(name: String,
         serverUrlString: String,
         testIp: String,
         testPort: UInt) {
        self.name = name
        self.serverUrlString = serverUrlString
        self.testIp = testIp
        self.testPort = testPort
    }
    
    func copyThis() -> ServerEnv {
        return ServerEnv(name: name, serverUrlString: serverUrlString, testIp: testIp, testPort: testPort)
    }
}
