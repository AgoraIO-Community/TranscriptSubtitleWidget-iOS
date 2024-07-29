//
//  EnvLocalSaveManager.swift
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/7/25.
//

import Foundation


class EnvLocalSaveManager {
    private let fileName = "customServerEnv"
    
    static let shared = EnvLocalSaveManager()
    
    init() {
        createCustomServerEnvFileIfNeed()
    }
    
    private func createCustomServerEnvFileIfNeed() {
        let fileManager = FileManager.default
        let path = NSHomeDirectory() + "/Documents/\(fileName)"
        if !fileManager.fileExists(atPath: path) {
            fileManager.createFile(atPath: path, contents: Data(), attributes: nil)
        }
    }
    
    func readCustomServerEnvs() -> [ServerEnv] {
        let path = NSHomeDirectory() + "/Documents/\(fileName)"
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let envs = try JSONDecoder().decode([ServerEnv].self, from: data)
            return envs
        } catch {
            print("read custom env error: \(error)")
            return []
        }
    }
    
    func writeCustomServerEnvs(envs: [ServerEnv]) {
        let path = NSHomeDirectory() + "/Documents/\(fileName)"
        do {
            let data = try JSONEncoder().encode(envs)
            try data.write(to: URL(fileURLWithPath: path))
        } catch {
            print("write custom env error: \(error)")
        }
    }
    
    func deleteCustomServerEnv(index: Int) {
        var envs = readCustomServerEnvs()
        envs.remove(at: index)
        writeCustomServerEnvs(envs: envs)
    }
    
    func addCustomServerEnv(env: ServerEnv) {
        var envs = readCustomServerEnvs()
        envs.append(env)
        writeCustomServerEnvs(envs: envs)
    }
}
