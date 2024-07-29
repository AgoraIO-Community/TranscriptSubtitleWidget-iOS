//
//  AppConfig.swift
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/7/9.
//

import Foundation

class AppConfig {
    static let share = AppConfig()
    
    var serverEnv: ServerEnv!
    
    var transcriptLangs: [AgoraLanguage] = [.chinese]
    var translateLangs: [AgoraLanguage] = [.english]
    
    func updateByConfig(appConfig: AppConfig) {
        serverEnv = appConfig.serverEnv
        transcriptLangs = appConfig.transcriptLangs
        translateLangs = appConfig.translateLangs
        saveServerEnv()
    }
    
    init() {
        loadServerEnv()
    }
    
    func copyThis() -> AppConfig {
        let config = AppConfig()
        config.serverEnv = serverEnv
        config.transcriptLangs = transcriptLangs
        config.translateLangs = translateLangs
        return config
    }
    
    /// 把serverEnv的内容写到info.plist
    func saveServerEnv() {
        let serverEnv = self.serverEnv
        let dict = ["name": serverEnv!.name,
                    "serverUrlString": serverEnv!.serverUrlString,
                    "testIp": serverEnv!.testIp,
                    "testPort": serverEnv!.testPort,
                    "appId": serverEnv!.appId,
                    "auth": serverEnv!.auth ?? ""] as [String : Any]
        UserDefaults.standard.set(dict, forKey: "serverEnv")
    }
    
    /// 从info.plist读取serverEnv的内容
    func loadServerEnv() {
        if let dict = UserDefaults.standard.dictionary(forKey: "serverEnv") {
            let name = dict["name"] as! String
            let serverUrlString = dict["serverUrlString"] as! String
            let testIp = dict["testIp"] as! String
            let testPort = dict["testPort"] as! UInt
            let appId = dict["appId"] as! String
            let auth = dict["auth"] as? String
            serverEnv = ServerEnv(name: name,
                                  serverUrlString: serverUrlString,
                                  testIp: testIp,
                                  testPort: testPort,
                                  appId: appId,
                                  auth: auth)
            return
        }
        
        serverEnv = KeyCenter.serverEnvs.first!
        saveServerEnv()
    }
}

class ServerEnv: Codable {
    var name: String
    var serverUrlString: String
    var testIp: String
    var testPort: UInt
    var appId: String
    var auth: String?
    
    init(name: String,
         serverUrlString: String,
         testIp: String,
         testPort: UInt,
         appId: String,
         auth: String?) {
        self.name = name
        self.serverUrlString = serverUrlString
        self.testIp = testIp
        self.testPort = testPort
        self.appId = appId
        self.auth = auth
    }
    
    func copyThis() -> ServerEnv {
        return ServerEnv(name: name,
                         serverUrlString: serverUrlString,
                         testIp: testIp,
                         testPort: testPort,
                         appId: appId,
                         auth: auth)
    }
}
