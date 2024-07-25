//
//  TestTranscriptSubtitleMachine+SearchTranscript.swift
//  AgoraTranscriptSubtitle-Unit-Tests
//
//  Created by ZYP on 2024/7/23.
//

import XCTest
@testable import AgoraTranscriptSubtitle

final class TestTranscriptSubtitleMachine_SearchTranscript: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// [F]
    func testExample1_1() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = -1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        let infos = [info1]
        
        let results = TranscriptSubtitleMachine.searchLastTranscriptMergeInfos(infos: infos)
        XCTAssertEqual(results.count, 1)
    }
    
    /// [T]
    func testExample1_2() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = 1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        let infos = [info1]
        
        let results = TranscriptSubtitleMachine.searchLastTranscriptMergeInfos(infos: infos)
        XCTAssertEqual(results.count, 1)
    }
    
    /// [F, F]
    func testExample2_1() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = -1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        
        let t2 = TranscriptInfo()
        t2.sentenceEndIndex = -1
        t2.startMs = 11
        t2.textTs = 20
        t2.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info2 = Info(transcriptInfo: t2, translateInfos: [])
        
        let infos = [info1, info2]
        
        let results = TranscriptSubtitleMachine.searchLastTranscriptMergeInfos(infos: infos)
        XCTAssertEqual(results.count, 2)
        XCTAssert(results.first!.transcriptInfo.startMs == 1)
        XCTAssert(results[1].transcriptInfo.startMs == 11)
    }
    
    /// [F, T]
    func testExample2_2() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = -1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        
        let t2 = TranscriptInfo()
        t2.sentenceEndIndex = 1
        t2.startMs = 11
        t2.textTs = 20
        t2.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info2 = Info(transcriptInfo: t2, translateInfos: [])
        
        let infos = [info1, info2]
        
        let results = TranscriptSubtitleMachine.searchLastTranscriptMergeInfos(infos: infos)
        XCTAssertEqual(results.count, 2)
        XCTAssert(results.first!.transcriptInfo.startMs == 1)
        XCTAssert(results[1].transcriptInfo.startMs == 11)
    }
    
    /// [T, F]
    func testExample2_3() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = 1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        
        let t2 = TranscriptInfo()
        t2.sentenceEndIndex = -1
        t2.startMs = 11
        t2.textTs = 20
        t2.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info2 = Info(transcriptInfo: t2, translateInfos: [])
        
        let infos = [info1, info2]
        
        let results = TranscriptSubtitleMachine.searchLastTranscriptMergeInfos(infos: infos)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results.first!.transcriptInfo.startMs == 11)
    }
    
    /// [T, T]
    func testExample2_4() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = 1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        
        let t2 = TranscriptInfo()
        t2.sentenceEndIndex = 1
        t2.startMs = 11
        t2.textTs = 20
        t2.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info2 = Info(transcriptInfo: t2, translateInfos: [])
        
        let infos = [info1, info2]
        
        let results = TranscriptSubtitleMachine.searchLastTranscriptMergeInfos(infos: infos)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results.first!.transcriptInfo.startMs == 11)
    }
    
    /// [F, F, F]
    func testExample3_1() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = -1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        
        let t2 = TranscriptInfo()
        t2.sentenceEndIndex = -1
        t2.startMs = 11
        t2.textTs = 20
        t2.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info2 = Info(transcriptInfo: t2, translateInfos: [])
        
        let t3 = TranscriptInfo()
        t3.sentenceEndIndex = -1
        t3.startMs = 21
        t3.textTs = 30
        t3.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info3 = Info(transcriptInfo: t3, translateInfos: [])
        
        let infos = [info1, info2, info3]
        
        let results = TranscriptSubtitleMachine.searchLastTranscriptMergeInfos(infos: infos)
        XCTAssertEqual(results.count, 3)
        XCTAssert(results[0].transcriptInfo.startMs == 1)
        XCTAssert(results[1].transcriptInfo.startMs == 11)
        XCTAssert(results[2].transcriptInfo.startMs == 21)
    }
    
    /// [F, F, T] 的测试case testExample3_2
    func testExample3_2() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = -1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        
        let t2 = TranscriptInfo()
        t2.sentenceEndIndex = -1
        t2.startMs = 11
        t2.textTs = 20
        t2.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info2 = Info(transcriptInfo: t2, translateInfos: [])
        
        let t3 = TranscriptInfo()
        t3.sentenceEndIndex = 1
        t3.startMs = 21
        t3.textTs = 30
        t3.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info3 = Info(transcriptInfo: t3, translateInfos: [])
        
        let infos = [info1, info2, info3]
        
        let results = TranscriptSubtitleMachine.searchLastTranscriptMergeInfos(infos: infos)
        XCTAssertEqual(results.count, 3)
        XCTAssert(results[0].transcriptInfo.startMs == 1)
        XCTAssert(results[1].transcriptInfo.startMs == 11)
        XCTAssert(results[2].transcriptInfo.startMs == 21)
    }
    
    /// [F, T, F] 的测试case
    func testExample3_3() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = -1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        
        let t2 = TranscriptInfo()
        t2.sentenceEndIndex = 1
        t2.startMs = 11
        t2.textTs = 20
        t2.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info2 = Info(transcriptInfo: t2, translateInfos: [])
        
        let t3 = TranscriptInfo()
        t3.sentenceEndIndex = -1
        t3.startMs = 21
        t3.textTs = 30
        t3.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info3 = Info(transcriptInfo: t3, translateInfos: [])
        
        let infos = [info1, info2, info3]
        
        let results = TranscriptSubtitleMachine.searchLastTranscriptMergeInfos(infos: infos)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results[0].transcriptInfo.startMs == 21)
    }
    
    /// [F, T, T] 的测试case
    func testExample3_4() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = -1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        
        let t2 = TranscriptInfo()
        t2.sentenceEndIndex = 1
        t2.startMs = 11
        t2.textTs = 20
        t2.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info2 = Info(transcriptInfo: t2, translateInfos: [])
        
        let t3 = TranscriptInfo()
        t3.sentenceEndIndex = 1
        t3.startMs = 21
        t3.textTs = 30
        t3.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info3 = Info(transcriptInfo: t3, translateInfos: [])
        
        let infos = [info1, info2, info3]
        
        let results = TranscriptSubtitleMachine.searchLastTranscriptMergeInfos(infos: infos)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results[0].transcriptInfo.startMs == 21)
    }
    
    /// [T, F, F] 的测试case
    func testExample3_5() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = 1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        
        let t2 = TranscriptInfo()
        t2.sentenceEndIndex = -1
        t2.startMs = 11
        t2.textTs = 20
        t2.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info2 = Info(transcriptInfo: t2, translateInfos: [])
        
        let t3 = TranscriptInfo()
        t3.sentenceEndIndex = -1
        t3.startMs = 21
        t3.textTs = 30
        t3.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info3 = Info(transcriptInfo: t3, translateInfos: [])
        
        let infos = [info1, info2, info3]
        
        let results = TranscriptSubtitleMachine.searchLastTranscriptMergeInfos(infos: infos)
        XCTAssertEqual(results.count, 2)
        XCTAssert(results[0].transcriptInfo.startMs == 11)
        XCTAssert(results[1].transcriptInfo.startMs == 21)
    }
    
    /// [T, F, T] 的测试case
    func testExample3_6() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = 1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        
        let t2 = TranscriptInfo()
        t2.sentenceEndIndex = -1
        t2.startMs = 11
        t2.textTs = 20
        t2.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info2 = Info(transcriptInfo: t2, translateInfos: [])
        
        let t3 = TranscriptInfo()
        t3.sentenceEndIndex = 1
        t3.startMs = 21
        t3.textTs = 30
        t3.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info3 = Info(transcriptInfo: t3, translateInfos: [])
        
        let infos = [info1, info2, info3]
        
        let results = TranscriptSubtitleMachine.searchLastTranscriptMergeInfos(infos: infos)
        XCTAssertEqual(results.count, 2)
        XCTAssert(results[0].transcriptInfo.startMs == 11)
        XCTAssert(results[1].transcriptInfo.startMs == 21)
    }
    
    /// [T, T, F] 的测试case
    func testExample3_7() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = 1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        
        let t2 = TranscriptInfo()
        t2.sentenceEndIndex = 1
        t2.startMs = 11
        t2.textTs = 20
        t2.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info2 = Info(transcriptInfo: t2, translateInfos: [])
        
        let t3 = TranscriptInfo()
        t3.sentenceEndIndex = -1
        t3.startMs = 21
        t3.textTs = 30
        t3.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info3 = Info(transcriptInfo: t3, translateInfos: [])
        
        let infos = [info1, info2, info3]
        
        let results = TranscriptSubtitleMachine.searchLastTranscriptMergeInfos(infos: infos)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results[0].transcriptInfo.startMs == 21)
    }
    
    /// [T, T, T] 的测试case
    func testExample3_8() throws {
        let t1 = TranscriptInfo()
        t1.sentenceEndIndex = 1
        t1.startMs = 1
        t1.textTs = 10
        t1.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info1 = Info(transcriptInfo: t1, translateInfos: [])
        
        let t2 = TranscriptInfo()
        t2.sentenceEndIndex = 1
        t2.startMs = 11
        t2.textTs = 20
        t2.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info2 = Info(transcriptInfo: t2, translateInfos: [])
        
        let t3 = TranscriptInfo()
        t3.sentenceEndIndex = 1
        t3.startMs = 21
        t3.textTs = 30
        t3.words = [
            .init(text: "一", isFinal: false, confidence: 0.1, startMs: 1, durationMs: 2)
        ]
        let info3 = Info(transcriptInfo: t3, translateInfos: [])
        
        let infos = [info1, info2, info3]
        
        let results = TranscriptSubtitleMachine.searchLastTranscriptMergeInfos(infos: infos)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results[0].transcriptInfo.startMs == 21)
    }
}
