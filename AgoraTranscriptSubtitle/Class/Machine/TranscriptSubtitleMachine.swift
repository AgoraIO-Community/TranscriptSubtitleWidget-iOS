//
//  TranscriptSubtitleMachine.swift
//  AgoraTranscriptSubtitle
//
//  Created by ZYP on 2024/6/21.
//

import UIKit
import AgoraComponetLog

@objcMembers
@objc(TranscriptSubtitleMachine)
public final class TranscriptSubtitleMachine: NSObject {
    let logTag = "Machine"
    private let deserializer = ProtobufDeserializer()
    private let queue = DispatchQueue(label: "agora.TranscriptSubtitleMachine.queue")
    var infoCache = InfoCache()
    var intermediateInfoCache = InfoCache()
    var showTranscriptContent: Bool = true
    public weak var delegate: TranscriptSubtitleMachineDelegate?
    
    var debugParam = DebugParam()
    weak var debug_intermediateDelegate: DebugMachineIntermediateDelegate?
    
    @objc public convenience init(loggers: [AgoraComponetLogger]) {
        self.init()
        Log.setLoggers(loggers: loggers)
        Log.info(text: "TranscriptSubtitleMachine init", tag: logTag)
    }
    
    private override init() {
        super.init()
    }
    
    @objc public func pushMessageData(data: Data) {
        queue.async { [weak self] in
            guard let self = self else {
                return
            }
            self._pushMessageData(data: data)
        }
    }
    
    @objc public func clear() {
        infoCache.clear()
        intermediateInfoCache.clear()
    }
    
    // MARK: - private
    private func _pushMessageData(data: Data) {
        if debugParam.dump_input {
            Log.debug(text: "data:\(data.base64EncodedString())", tag: logTag)
        }
        
        guard let message = deserializer.deserialize(data: data) else {
            Log.errorText(text: "deserialize fail: \(data.base64EncodedString())", tag: logTag)
            return
        }
        
        if debugParam.dump_deserialize {
            Log.debug(text: "deserialize:\(message.jsonString)", tag: logTag)
        }
        
        _handleMessage(message: message, uid: message.uid)
    }
}
