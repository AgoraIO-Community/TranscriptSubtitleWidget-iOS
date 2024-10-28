//
//  TranscriptSubtitleMachine+Events.swift
//  AgoraTranscriptSubtitle
//
//  Created by ZYP on 2024/6/24.
//

import Foundation

@objc public protocol TranscriptSubtitleMachineDelegate: NSObjectProtocol {
    func transcriptSubtitleMachine(_ machine: TranscriptSubtitleMachine, didAddRenderInfo renderInfo: RenderInfo)
    func transcriptSubtitleMachine(_ machine: TranscriptSubtitleMachine, didUpadteRenderInfo renderInfo: RenderInfo)
}

@objc public protocol DebugMachineIntermediateDelegate: NSObjectProtocol {
    func debugMachineIntermediate(_ machine: TranscriptSubtitleMachine, diduUpdate infos: [Info])
}
