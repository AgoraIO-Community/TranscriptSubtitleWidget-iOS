//
//  TranscriptSubtitleView.swift
//  AgoraTranscriptSubtitle
//
//  Created by ZYP on 2024/6/17.
//

import UIKit
import AgoraComponetLog

/// The view for displaying transcript and translation subtitles.
@objc public class TranscriptSubtitleView: UIView {
    private let messageView = MessageView()
    private let transcriptSubtitleMachine = TranscriptSubtitleMachine()
    private let logTag = "TranscriptSubtitleView"
    
    /// The color of text when the recognition state is final.
    @objc public var finalTextColor: UIColor = .white { didSet{ updateParam(varName:"finalTextColor") }}
    /// The color of text when the recognition state is non-final.
    @objc public var nonFinalTextColor: UIColor = .gray { didSet{ updateParam(varName:"nonFinalTextColor") }}
    /// The font used for displaying text, including both transcript and translated content.
    @objc public var textFont: UIFont = .systemFont(ofSize: 16) { didSet{ updateParam(varName:"textFont") }}
    /// The background color of the text area.
    @objc public var textAreaBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.25) { didSet{ updateParam(varName:"textAreaBackgroundColor") }}
    /// A Boolean value indicating whether to show the transcript content.
    @objc public var showTranscriptContent = true { didSet{ updateParam(varName:"showTranscriptContent") }}
    
    @objc public var debugParam = DebugParam() { didSet { updateDebugParam() } }
     
    // MARK: - Public Method
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    /// - Parameter frame: The frame rectangle for the view, measured in points.
    /// - Parameter loggers: The loggers used to log the debug information.
    /// - Returns: An initialized view object.
    @objc public convenience init(frame: CGRect, loggers: [AgoraComponetLogger] = [AgoraComponetConsoleLogger(domainName: "ATS"), AgoraComponetFileLogger(logFilePath: nil, filePrefixName: "agora.AgoraTranscriptSubtitle", maxFileSizeOfBytes: 1024 * 1024 * 1, maxFileCount: 4, domainName: "ATS", internalLogSaveInFile: true)]) {
        Log.setLoggers(loggers: loggers)
        self.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        Log.debug(text: "version \(String.versionName)", tag: logTag)
        setupUI()
        commonInit()
    }
    
    deinit {
        Log.info(text: "deinit", tag: logTag)
    }
    
    /// Pushes message data received from the STT (Speech-to-Text) server to processing.
    /// - Parameter data: The raw data packet containing the message, received from RTC data Stream.
    /// - Parameter uid: The unique identifier of the user who generated this data, used for attribution and processing purposes.
    @objc public func pushMessageData(data: Data, uid: UInt) {
        transcriptSubtitleMachine.pushMessageData(data: data, uid: uid)
    }
    
    /// Clears all data, leaving the view in an empty state.
    @objc public func clear() {
        transcriptSubtitleMachine.clear()
        messageView.clear()
    }
    
    /// Get current all text of translation
    @objc public func getAllTranslateText() -> String {
        messageView.getAllTranslateText()
    }
    
    /// Get current all text of transcript
    @objc public func getAllTranscriptText() -> String {
        messageView.getAllTranscriptText()
    }
    
    // MARK: - Private Method
    private func setupUI() {
        backgroundColor = .clear
        messageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageView)
        messageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        messageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        messageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func commonInit() {
        transcriptSubtitleMachine.delegate = self
    }
    
    private func updateDebugParam() {
        Log.info(text: "debug param was updated: \(debugParam)", tag: logTag)
        transcriptSubtitleMachine.debugParam = debugParam
    }
    
    private func updateParam(varName: String) {
        switch varName {
        case "finalTextColor":
            messageView.finalTextColor = finalTextColor
            Log.info(text: "param was updated, \(varName) = \(finalTextColor)", tag: logTag)
            break
        case "nonFinalTextColor":
            messageView.nonFinalTextColor = nonFinalTextColor
            Log.info(text: "param was updated, \(varName) = \(nonFinalTextColor)", tag: logTag)
            break
        case "textFont":
            messageView.textFont = textFont
            Log.info(text: "param was updated, \(varName) = \(textFont)", tag: logTag)
            break
        case "textAreaBackgroundColor":
            messageView.textAreaBackgroundColor = textAreaBackgroundColor
            Log.info(text: "param was updated, \(varName) = \(textAreaBackgroundColor)", tag: logTag)
            break
        case "showTranscriptContent":
            transcriptSubtitleMachine.showTranscriptContent = showTranscriptContent
            Log.info(text: "param was updated, \(varName) = \(showTranscriptContent)", tag: logTag)
            break
        default:
            Log.errorText(text: "unknow var update \(varName)", tag: logTag)
            fatalError("unknow var update \(varName)")
        }
    }
}

// MARK: - TranscriptSubtitleMachineDelegate
extension TranscriptSubtitleView: TranscriptSubtitleMachineDelegate {
    func transcriptSubtitleMachine(_ machine: TranscriptSubtitleMachine, didAddRenderInfo renderInfo: RenderInfo) {
        messageView.addOrUpdate(renderInfo: renderInfo)
    }
    
    func transcriptSubtitleMachine(_ machine: TranscriptSubtitleMachine, didUpadteRenderInfo renderInfo: RenderInfo) {
        messageView.addOrUpdate(renderInfo: renderInfo)
    }
}
