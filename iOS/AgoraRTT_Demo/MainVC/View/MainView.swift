//
//  MainView.swift
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/6/21.
//

import UIKit
import AgoraTranscriptSubtitle

protocol MainViewDelegate: NSObjectProtocol {
    func mainViewDidTapAction(action: MainView.Action)
}

class MainView: UIView {
    let rttView = TranscriptSubtitleView(frame: .zero, loggers: [ConsoleLogger(), FileLogger()])
    let showAllTransciptButton = UIButton(type: .roundedRect)
    let showAllTranslateButton = UIButton(type: .roundedRect)
    weak var delegate: MainViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        showAllTransciptButton.setTitleColor(.white, for: .normal)
        showAllTranslateButton.setTitleColor(.white, for: .normal)
        showAllTransciptButton.setTitle("all转写", for: .normal)
        showAllTranslateButton.setTitle("all翻译", for: .normal)
        showAllTransciptButton.backgroundColor = .blue
        showAllTranslateButton.backgroundColor = .blue
        
        backgroundColor = .clear
        rttView.backgroundColor = .clear
        backgroundColor = .white
        addSubview(rttView)
        addSubview(showAllTransciptButton)
        addSubview(showAllTranslateButton)
        
        rttView.translatesAutoresizingMaskIntoConstraints = false
        showAllTransciptButton.translatesAutoresizingMaskIntoConstraints = false
        showAllTranslateButton.translatesAutoresizingMaskIntoConstraints = false
        
        rttView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        rttView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        rttView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        rttView.bottomAnchor.constraint(equalTo: showAllTransciptButton.topAnchor).isActive = true
        
        showAllTransciptButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        showAllTransciptButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        showAllTransciptButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        showAllTranslateButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        showAllTranslateButton.bottomAnchor.constraint(equalTo: showAllTransciptButton.bottomAnchor).isActive = true
        showAllTranslateButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func commonInit() {
        showAllTransciptButton.addTarget(self, action: #selector(buttonTap(_:)), for: .touchUpInside)
        showAllTranslateButton.addTarget(self, action: #selector(buttonTap(_:)), for: .touchUpInside)
    }

    @objc func buttonTap(_ sender: UIButton) {
        if sender == showAllTransciptButton {
            delegate?.mainViewDidTapAction(action: .showAllTranscipt)
        }
        if sender == showAllTranslateButton {
            delegate?.mainViewDidTapAction(action: .showAllTranslate)
        }
    }
}

extension MainView {
    enum Action {
        case showAllTranscipt
        case showAllTranslate
    }
}
