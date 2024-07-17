//
//  Events.swift
//  NewApi
//
//  Created by ZYP on 2022/11/22.
//

import Foundation

@objc public protocol ILogger {
    /// log out put
    /// - Note: run in a specific queue
    @objc func onLog(content: String, tag: String?, time: String, level: LoggerLevel)
}

@objc public enum LoggerLevel: UInt8, CustomStringConvertible {
    case debug, info, warning, error
    
    public var description: String {
        switch self {
        case .debug:
            return "D"
        case .info:
            return "I"
        case .warning:
            return "W"
        case .error:
            return "E"
        }
    }
}
