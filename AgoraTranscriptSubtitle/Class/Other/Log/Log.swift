//
//  LogProvider.swift
//  
//
//  Created by ZYP on 2021/5/28.
//

import AgoraComponetLog
import UIKit

class Log {
    static let provider = AgoraComponetLog(queueTag: "")
    
    static func errorText(text: String,
                          tag: String? = nil) {
        provider.error(withText: text, tag: tag)
    }
    
    static func error(error: CustomStringConvertible,
                      tag: String? = nil) {
        provider.error(withText: error.description, tag: tag)
    }
    
    static func info(text: String,
                     tag: String? = nil) {
        provider.info(withText: text, tag: tag)
    }
    
    static func debug(text: String,
                      tag: String? = nil) {
        provider.debug(withText: text, tag: tag)
    }
    
    static func warning(text: String,
                        tag: String? = nil) {
        provider.warning(withText: text, tag: tag)
    }
    
    static func setLoggers(loggers: [AgoraComponetLogger]) {
        provider.configLoggers(loggers)
    }
}
