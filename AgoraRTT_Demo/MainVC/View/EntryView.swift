//
//  EntryView.swift
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/6/21.
//

import UIKit

protocol EntryViewDelegate: NSObjectProtocol {
    func onButtonAction(action: EntryView.Action, channelName: String)
    func onVocsBtnValueChange(value: Bool)
}

class EntryView: UIView {
    weak var delegate: EntryViewDelegate?
    
    let joinHostButton: UIButton = {
        let button = UIButton()
        button.setTitle("Join As Host", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.backgroundColor = .orange
        return button
    }()
    
    let joinAudienceButton: UIButton = {
        let button = UIButton()
        button.setTitle("Join As Audioence", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.backgroundColor = .systemBlue
        return button
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Room ID"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let settingLabel = UILabel()
    let vocsLabel = UILabel()
    let vocsSwitchButton = UISwitch()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(joinHostButton)
        addSubview(joinAudienceButton)
        addSubview(textField)
        addSubview(settingLabel)
        addSubview(vocsSwitchButton)
        addSubview(vocsLabel)
        
        vocsLabel.text = "use staging in rtc"
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        joinHostButton.translatesAutoresizingMaskIntoConstraints = false
        joinAudienceButton.translatesAutoresizingMaskIntoConstraints = false
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        vocsSwitchButton.translatesAutoresizingMaskIntoConstraints = false
        vocsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            joinHostButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            joinHostButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            joinHostButton.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -10),
            joinHostButton.heightAnchor.constraint(equalToConstant: 100),
            
            joinAudienceButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            joinAudienceButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 10),
            joinAudienceButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            joinAudienceButton.heightAnchor.constraint(equalToConstant: 100),
            
            settingLabel.topAnchor.constraint(equalTo: joinHostButton.bottomAnchor, constant: 30),
            settingLabel.leftAnchor.constraint(equalTo: joinHostButton.leftAnchor, constant: 0),
            settingLabel.rightAnchor.constraint(equalTo: joinAudienceButton.rightAnchor),
            
            vocsLabel.topAnchor.constraint(equalTo: settingLabel.bottomAnchor, constant: 10),
            vocsLabel.leftAnchor.constraint(equalTo: settingLabel.leftAnchor),
            vocsSwitchButton.centerYAnchor.constraint(equalTo: vocsLabel.centerYAnchor),
            vocsSwitchButton.leftAnchor.constraint(equalTo: vocsLabel.rightAnchor, constant: 10)
        ])
    }

    private func commonInit() {
        textField.text = "\(Int.random(in: 0...100))"
        joinHostButton.addTarget(self, action: #selector(onButton(_:)), for: .touchUpInside)
        joinAudienceButton.addTarget(self, action: #selector(onButton(_:)), for: .touchUpInside)
        vocsSwitchButton.addTarget(self, action: #selector(onSwitch(_:)), for: .valueChanged)
    }
    
    @objc private func onButton(_ sender: UIButton) {
        guard let channelName = textField.text, !channelName.isEmpty else {
            return
        }
        let action: Action = sender == joinHostButton ? .joinHost : .joinAudience
        delegate?.onButtonAction(action: action, channelName: channelName)
    }
    
    @objc func onSwitch(_ sender: UISwitch) {
        delegate?.onVocsBtnValueChange(value: sender.isOn)
    }
}

extension EntryView {
    enum Action {
        case joinHost
        case joinAudience
    }
}
