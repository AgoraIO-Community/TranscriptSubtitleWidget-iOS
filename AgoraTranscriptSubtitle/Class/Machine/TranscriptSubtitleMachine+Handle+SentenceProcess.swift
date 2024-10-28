//
//  TranscriptSubtitleMachine+Handle+PreProcess.swift
//  AgoraTranscriptSubtitle
//
//  Created by ZYP on 2024/6/28.
//

import Foundation

extension TranscriptSubtitleMachine {
    func _handleTranscriptPreProcess(message: ProtobufDeserializer.DataStreamMessage, uid: UidType) {
        let words = message.splitToTranscriptWords
        
        if let lastOne = infoCache.getLastInfo(uid: uid), !lastOne.transcriptInfo.words.isFinal { /** append */
            lastOne.transcriptInfo.words = words
            lastOne.transcriptInfo.duration += message.durationMs
            lastOne.transcriptInfo.textTs = message.textTs
            lastOne.transcriptInfo.sentenceEndIndex = message.sentenceEndIndex
            if debugParam.useFinalTagAsParagraphDistinction {
                let renderInfo = convertToRenderInfo(uid: message.uid,
                                                     info: lastOne,
                                                     useTranscriptText: showTranscriptContent)
                invokeUpdate(self, renderInfo: renderInfo)
            }
        }
        else {
            let transcriptInfo = TranscriptInfo()
            transcriptInfo.startMs = message.textTs
            transcriptInfo.textTs = message.textTs
            transcriptInfo.duration = message.durationMs
            transcriptInfo.words = words
            transcriptInfo.sentenceEndIndex = message.sentenceEndIndex
            let info = Info(transcriptInfo: transcriptInfo, translateInfos: [])
            infoCache.addInfo(uid: uid, info: info)
            if debugParam.useFinalTagAsParagraphDistinction {
                let renderInfo = convertToRenderInfo(uid: message.uid,
                                                     info: info,
                                                     useTranscriptText: showTranscriptContent)
                invokeAdd(self, renderInfo: renderInfo)
            }
        }
    }
    
    func _handleTranlatePreProcess(message: ProtobufDeserializer.DataStreamMessage, uid: UidType) {
        let translateWords = message.translateWords
        if let lastOne = infoCache.getLast(uid: uid, with: message.textTs) { /** append */
            updateTranslateInfo_Pre(info: lastOne,
                                    words: translateWords,
                                    duration: message.durationMs,
                                    textTs: message.textTs)
            if debugParam.useFinalTagAsParagraphDistinction {
                let renderInfo = convertToRenderInfo(uid: message.uid,
                                                     info: lastOne,
                                                     useTranscriptText: showTranscriptContent)
                invokeUpdate(self, renderInfo: renderInfo)
            }
            return
        }
        
        Log.errorText(text: "get a tarnslate message but no transcript message before it. textTs:\(message.textTs) content:\(message.debug_translateBeautyString)", tag: logTag)
    }
}
