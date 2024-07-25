//
//  TranscriptSubtitleMachine+Handle+Calculate.swift
//  AgoraTranscriptSubtitle
//
//  Created by ZYP on 2024/6/28.
//

import Foundation

extension TranscriptSubtitleMachine {
    func convertToRenderInfo(info: Info, useTranscriptText: Bool) -> RenderInfo {
        let transcriptString = useTranscriptText ? info.transcriptInfo.words.allText : ""
        var index = 0
        var transcriptRanges = [SegmentRangeInfo]()
        if useTranscriptText {
            for w in info.transcriptInfo.words {
                let range = NSRange(location: index, length: w.text.count)
                let segment = SegmentRangeInfo(range: range, isFinal: w.isFinal)
                transcriptRanges.append(segment)
                index += w.text.count
            }
        }
        
        var translateRenderInfos = [TranslateRenderInfo]()
        for translateInfo in info.translateInfos {
            index = 0
            var ranges = [SegmentRangeInfo]()
            let string = translateInfo.words.map({ $0.text }).joined()
            var lang = ""
            for w in translateInfo.words {
                let range = NSRange(location: index, length: w.text.count)
                let segment = SegmentRangeInfo(range: range, isFinal: w.isFinal)
                ranges.append(segment)
                lang = w.lang
                index += w.text.count
            }
            
            let translateRenderInfo = TranslateRenderInfo(lang: lang, text: string, ranges: ranges)
            translateRenderInfos.append(translateRenderInfo)
        }
        
        return RenderInfo(identifier: info.transcriptInfo.startMs,
            transcriptText: transcriptString,
                                      transcriptRanges: transcriptRanges,
                                      translateRenderInfos: translateRenderInfos)
    }
    
    func updateTranslateInfo_Pre(info: Info,
                             words: [TranslateWord],
                             duration: Int32,
                             textTs: Int64) {
        guard let lang = words.first?.lang else {
            Log.errorText(text: "updateTranslateInfo fail, can not find a lange", tag: self.logTag)
            return
        }
        
        if let translateInfo = info.translateInfos.first(where: { $0.words.lang! == lang }) {
            translateInfo.words = words
        }
        else {
            let translateInfo = TranslateInfo()
            translateInfo.startMs = textTs
            translateInfo.words = words
            info.translateInfos.append(translateInfo)
        }
    }
    
    func updateTranslateInfo_Post(intermediateInfo: Info,
                              willMergeInfos: [Info]) {
        /// collect all TranslateWord
        var translateWordDict = [String : [TranslateWord]]()
        for willMergeInfo in willMergeInfos {
            for translateInfo in willMergeInfo.translateInfos {
                if let lang = translateInfo.words.first?.lang {
                    translateWordDict[lang] = (translateWordDict[lang] ?? []) + translateInfo.words
                }
            }
        }
        
        /// update intermediateInfo
        for (lang, words) in translateWordDict {
            if let translateInfo = intermediateInfo.translateInfos.first(where: { $0.words.lang! == lang }) {
                translateInfo.words = words
            }
            else {
                let translateInfo = TranslateInfo()
                translateInfo.words = words
                intermediateInfo.translateInfos.append(translateInfo)
            }
        }
    }
    
    /// find infos which need to merge, in tranlsate message's textTs
    static func searchTranslateMergeInfos(infos: [Info], textTs: Int64) -> [Info] {
        let allReversedInfos = infos.reversed()
        
        var willMergeInfos = [Info]()
        var isMatchTranscriptTime = false
        for (index, info) in allReversedInfos.enumerated() {
            if info.transcriptInfo.paragraphEnd {
                if isMatchTranscriptTime {
                    break
                }
                
                /// reset
                isMatchTranscriptTime = false
                willMergeInfos = [Info]()
            }
            
            willMergeInfos.append(info)
            if textTs >= info.transcriptInfo.startMs, textTs <= info.transcriptInfo.textTs {
                isMatchTranscriptTime = true
            }
            
            if index == allReversedInfos.count - 1 { /// 遍历到最后一个
                if isMatchTranscriptTime {
                    break
                }
                
                /// reset
                isMatchTranscriptTime = false
                willMergeInfos = [Info]()
            }
        }
        
        willMergeInfos = willMergeInfos.reversed()
        return willMergeInfos
    }
    
    static func searchLastTranscriptMergeInfos(infos: [Info]) -> [Info] {
        var allReversedInfos = infos.reversed()
        var willMergeInfos = [Info]()
        
        for (index, info) in allReversedInfos.enumerated() {
            if index == 0, info.transcriptInfo.paragraphEnd {
                willMergeInfos.append(info)
                continue
            }
            
            if index == 0, !info.transcriptInfo.paragraphEnd {
                willMergeInfos.append(info)
                continue
            }
            
            if index != 0, info.transcriptInfo.paragraphEnd {
                break
            }
            
            if index != 0, !info.transcriptInfo.paragraphEnd {
                willMergeInfos.append(info)
                continue
            }
        }
        
        willMergeInfos = willMergeInfos.reversed()
        return willMergeInfos
    }
}
