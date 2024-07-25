//
//  TestTranscriptSubtitleMachine3.swift
//  AgoraTranscriptSubtitle-Unit-Tests
//
//  Created by ZYP on 2024/7/23.
//

import XCTest
@testable import AgoraTranscriptSubtitle

final class TestTranscriptSubtitleMachine_SearchTranslate1: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchTranslateMergeInfos1() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = -1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info = Info(transcriptInfo: t1, translateInfos: [])
        
        
        let results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: [info], textTs: 5)
        XCTAssertEqual(results.count, 1)
    }
    
    func testSearchTranslateMergeInfos2() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = 1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: true, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        
        let t2 = TranscriptInfo()
        t2.sentenceEndIndex = -1
        t2.startMs = 11
        t2.textTs = 20
        t2.words = [
            .init(text: "二", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info2 = Info(transcriptInfo: t2, translateInfos: [])
        
        var results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: [info1, info2], textTs: 0)
        XCTAssertEqual(results.count, 0)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: [info1, info2], textTs: 5)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results.first!.transcriptInfo.startMs == 1)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: [info1, info2], textTs: 15)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results.first!.transcriptInfo.startMs == 11)
    }
    
    func testSearchTranslateMergeInfos3() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = 1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: true, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        
        let t2 = TranscriptInfo()
        t2.sentenceEndIndex = 1
        t2.startMs = 11
        t2.textTs = 20
        t2.words = [
            .init(text: "二", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info2 = Info(transcriptInfo: t2, translateInfos: [])
        
        let t3 = TranscriptInfo()
        t3.sentenceEndIndex = -1
        t3.startMs = 21
        t3.textTs = 30
        t3.words = [
            .init(text: "三", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info3 = Info(transcriptInfo: t3, translateInfos: [])
        let infos = [info1, info2, info3]
        
        var results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 0)
        XCTAssertEqual(results.count, 0)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 5)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results.first!.transcriptInfo.startMs == 1)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 15)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results.first!.transcriptInfo.startMs == 11)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 25)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results.first!.transcriptInfo.startMs == 21)
    }

    func testSearchTranslateMergeInfos4() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = 1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: true, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        
        let t2 = TranscriptInfo()
        t2.sentenceEndIndex = 1
        t2.startMs = 11
        t2.textTs = 20
        t2.words = [
            .init(text: "二", isFinal: true, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info2 = Info(transcriptInfo: t2, translateInfos: [])
        
        let t3 = TranscriptInfo()
        t3.sentenceEndIndex = -1
        t3.startMs = 21
        t3.textTs = 30
        t3.words = [
            .init(text: "三", isFinal: true, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info3 = Info(transcriptInfo: t3, translateInfos: [])
        
        let t4 = TranscriptInfo()
        t4.sentenceEndIndex = -1
        t4.startMs = 31
        t4.textTs = 40
        t4.words = [
            .init(text: "四", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info4 = Info(transcriptInfo: t4, translateInfos: [])
        
        let infos = [info1, info2, info3, info4]
        
        var results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 0)
        XCTAssertEqual(results.count, 0)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 5)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results.first!.transcriptInfo.startMs == 1)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 15)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results.first!.transcriptInfo.startMs == 11)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 25)
        XCTAssertEqual(results.count, 2)
        XCTAssert(results.first!.transcriptInfo.startMs == 21)
        XCTAssert(results.last!.transcriptInfo.startMs == 31)
    }
    
    func testSearchTranslateMergeInfos5() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = 1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: true, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        
        let t2 = TranscriptInfo()
        t2.sentenceEndIndex = 1
        t2.startMs = 11
        t2.textTs = 20
        t2.words = [
            .init(text: "二", isFinal: true, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info2 = Info(transcriptInfo: t2, translateInfos: [])
        
        let t3 = TranscriptInfo()
        t3.sentenceEndIndex = -1
        t3.startMs = 21
        t3.textTs = 30
        t3.words = [
            .init(text: "三", isFinal: true, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info3 = Info(transcriptInfo: t3, translateInfos: [])
        
        let t4 = TranscriptInfo()
        t4.sentenceEndIndex = -1
        t4.startMs = 31
        t4.textTs = 40
        t4.words = [
            .init(text: "四", isFinal: true, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info4 = Info(transcriptInfo: t4, translateInfos: [])
        
        let t5 = TranscriptInfo()
        t5.sentenceEndIndex = 1
        t5.startMs = 41
        t5.textTs = 50
        t5.words = [
            .init(text: "五", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info5 = Info(transcriptInfo: t5, translateInfos: [])
        
        let infos = [info1, info2, info3, info4, info5]
        
        var results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 0)
        XCTAssertEqual(results.count, 0)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 5)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results.first!.transcriptInfo.startMs == 1)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 15)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results.first!.transcriptInfo.startMs == 11)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 25)
        XCTAssertEqual(results.count, 3)
        XCTAssert(results.first!.transcriptInfo.startMs == 21)
        XCTAssert(results[1].transcriptInfo.startMs == 31)
        XCTAssert(results.last!.transcriptInfo.startMs == 41)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 35)
        XCTAssertEqual(results.count, 3)
        XCTAssert(results.first!.transcriptInfo.startMs == 21)
        XCTAssert(results[1].transcriptInfo.startMs == 31)
        XCTAssert(results.last!.transcriptInfo.startMs == 41)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 45)
        XCTAssertEqual(results.count, 3)
        XCTAssert(results.first!.transcriptInfo.startMs == 21)
        XCTAssert(results[1].transcriptInfo.startMs == 31)
        XCTAssert(results.last!.transcriptInfo.startMs == 41)
    }
    
    func testSearchTranslateMergeInfos6() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = 1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: true, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        
        let t2 = TranscriptInfo()
        t2.sentenceEndIndex = 1
        t2.startMs = 11
        t2.textTs = 20
        t2.words = [
            .init(text: "二", isFinal: true, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info2 = Info(transcriptInfo: t2, translateInfos: [])
        
        let t3 = TranscriptInfo()
        t3.sentenceEndIndex = -1
        t3.startMs = 21
        t3.textTs = 30
        t3.words = [
            .init(text: "三", isFinal: true, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info3 = Info(transcriptInfo: t3, translateInfos: [])
        
        let t4 = TranscriptInfo()
        t4.sentenceEndIndex = -1
        t4.startMs = 31
        t4.textTs = 40
        t4.words = [
            .init(text: "四", isFinal: true, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info4 = Info(transcriptInfo: t4, translateInfos: [])
        
        let t5 = TranscriptInfo()
        t5.sentenceEndIndex = 1
        t5.startMs = 41
        t5.textTs = 50
        t5.words = [
            .init(text: "五", isFinal: true, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info5 = Info(transcriptInfo: t5, translateInfos: [])
        
        let t6 = TranscriptInfo()
        t6.sentenceEndIndex = -1
        t6.startMs = 51
        t6.textTs = 60
        t6.words = [
            .init(text: "六", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info6 = Info(transcriptInfo: t6, translateInfos: [])
        
        let infos = [info1, info2, info3, info4, info5, info6]
        
        var results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 0)
        XCTAssertEqual(results.count, 0)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 5)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results.first!.transcriptInfo.startMs == 1)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 15)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results.first!.transcriptInfo.startMs == 11)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 25)
        XCTAssertEqual(results.count, 3)
        XCTAssert(results.first!.transcriptInfo.startMs == 21)
        XCTAssert(results[1].transcriptInfo.startMs == 31)
        XCTAssert(results.last!.transcriptInfo.startMs == 41)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 35)
        XCTAssertEqual(results.count, 3)
        XCTAssert(results.first!.transcriptInfo.startMs == 21)
        XCTAssert(results[1].transcriptInfo.startMs == 31)
        XCTAssert(results.last!.transcriptInfo.startMs == 41)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 45)
        XCTAssertEqual(results.count, 3)
        XCTAssert(results.first!.transcriptInfo.startMs == 21)
        XCTAssert(results[1].transcriptInfo.startMs == 31)
        XCTAssert(results.last!.transcriptInfo.startMs == 41)
        
        results = TranscriptSubtitleMachine.searchTranslateMergeInfos(infos: infos, textTs: 55)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results.first!.transcriptInfo.startMs == 51)
    }
}
