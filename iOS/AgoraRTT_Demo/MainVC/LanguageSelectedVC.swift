//
//  LanguageSelectedVC.swift
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/7/9.
//

import UIKit


protocol LanguageSelectedVCDelegate: NSObjectProtocol {
    func languageSelectedVCDidSelected(langs: [AgoraLanguage])
}

class LanguageSelectedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableview = UITableView(frame: .zero, style: .grouped)
    private var dataList = [String]()
    private let button = UIButton()
    private var selectedIndexs = [Int]()
    var isMutiSelect = false
    weak var delegate: LanguageSelectedVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        commonInit()
    }
    
    func setupUI() {
        button.setTitle("确 定", for: .normal)
        button.backgroundColor = .red
        view.backgroundColor = .white
        view.addSubview(tableview)
        view.addSubview(button)
        
        tableview.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        tableview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        button.topAnchor.constraint(equalTo: tableview.bottomAnchor, constant: 10).isActive = true
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 45).isActive = true
    }
    
    func commonInit() {
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.dataSource = self
        tableview.delegate = self
        button.addTarget(self, action: #selector(buttonTap(_:)), for: .touchUpInside)
        for language in AgoraLanguage.allCases {
            dataList.append(language.rawValue)
        }
        tableview.reloadData()
    }
    
    @objc func buttonTap(_ sender: UIButton) {
        var temp = [AgoraLanguage]()
        for i in selectedIndexs {
            temp.append(AgoraLanguage(rawValue: dataList[i])!)
        }
        delegate?.languageSelectedVCDidSelected(langs: temp)
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataList[indexPath.row]
        selectedIndexs.contains(indexPath.row) ? (cell.accessoryType = .checkmark) : (cell.accessoryType = .none)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isMutiSelect {
            if selectedIndexs.contains(indexPath.row) {
                selectedIndexs.removeAll { $0 == indexPath.row }
            } else {
                selectedIndexs.append(indexPath.row)
            }
        } else {
            selectedIndexs.removeAll()
            selectedIndexs.append(indexPath.row)
        }
        tableView.reloadData()
    }
    
}
