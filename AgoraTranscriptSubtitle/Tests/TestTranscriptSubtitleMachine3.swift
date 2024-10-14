//
//  TestTranscriptSubtitleMachine3.swift
//  AgoraTranscriptSubtitle-Unit-Tests
//
//  Created by ZYP on 2024/7/23.
//

import XCTest
@testable import AgoraTranscriptSubtitle
import AgoraComponetLog
final class TestTranscriptSubtitleMachine3: XCTestCase, TranscriptSubtitleMachineDelegate {
    let transcriptSubtitleMachine = TranscriptSubtitleMachine(loggers: [AgoraComponetConsoleLogger()])
    let exp1 = XCTestExpectation(description: "exp1")
    let exp2 = XCTestExpectation(description: "exp2")
    let exp3 = XCTestExpectation(description: "exp3")
    let exp4 = XCTestExpectation(description: "exp4")

    override func setUpWithError() throws {
        transcriptSubtitleMachine.delegate = self
        transcriptSubtitleMachine.debugParam = .init(dump_input: true,
                                                     dump_deserialize: true,
                                                     useFinalTagAsParagraphDistinction: false,
                                                     showTranslateContent: true)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let datas = DataStreamFileFetch.fetch(fileName: "dataStreamResults11.txt")
        for (_, data) in datas.enumerated() {
            transcriptSubtitleMachine.pushMessageData(data: data, uid: 0)
        }
        
        wait(for: [exp1, exp2, exp3, exp4], timeout: 10)
    }
    
    func transcriptSubtitleMachine(_ machine: AgoraTranscriptSubtitle.TranscriptSubtitleMachine, didAddRenderInfo renderInfo: AgoraTranscriptSubtitle.RenderInfo) {
        
    }
    
    func transcriptSubtitleMachine(_ machine: AgoraTranscriptSubtitle.TranscriptSubtitleMachine, didUpadteRenderInfo renderInfo: AgoraTranscriptSubtitle.RenderInfo) {
        if renderInfo.transcriptText == "你老公多大了？", let translateRenderInfo = renderInfo.translateRenderInfos.first {
            
            if translateRenderInfo.text == "How old is your husband? " {
                exp1.fulfill()
                exp2.fulfill()
            }
        }
        
        if renderInfo.transcriptText == "那您这么多年过得太不容易了。我也是，但它外酥里嫩，香甜可口，真是让人回味无穷。是啊，我最喜欢巧克力蛋挞，浓郁的巧克力味儿和蛋奶香融合在一起。", let translateRenderInfo = renderInfo.translateRenderInfos.first {
            
            if translateRenderInfo.text == "You have been through so much over the years. I am also, but it is crispy on the outside and tender and sweet inside. It is really delicious and makes people linger over it. Yes, I like chocolate egg tarts the most, with a rich chocolate flavor." {
                exp3.fulfill()
                exp4.fulfill()
            }
        }
    }
}
