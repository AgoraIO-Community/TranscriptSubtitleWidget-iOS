//
//  TextShowVC.swift
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/7/9.
//

import UIKit
import SVProgressHUD

class TextShowVC: UIViewController {
    let textView = UITextView()
    let button = UIButton(type: .roundedRect)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        commonInit()
    }
    
    func setupUI() {
        button.backgroundColor = .blue
        button.setTitle("拷贝", for: .normal)
        button.setTitleColor(.white, for: .normal)
        view.backgroundColor = .white
        view.addSubview(textView)
        view.addSubview(button)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.leftAnchor.constraint(equalTo: view.leftAnchor),
            textView.rightAnchor.constraint(equalTo: view.rightAnchor),
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func commonInit() {
        button.addTarget(self, action: #selector(buttonTap(_:)), for: .touchUpInside)
    }
    
    @objc func buttonTap(_ sender: UIButton) {
        /// 把文本拷贝到粘贴板
        UIPasteboard.general.string = textView.text
        SVProgressHUD.showInfo(withStatus: "已拷贝")
    }
}
