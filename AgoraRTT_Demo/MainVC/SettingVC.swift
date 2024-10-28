//
//  ConfigVC.swift
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/7/9.
//

import UIKit

struct Section {
    let title: String
    let rows: [Row]
}

struct Row {
    let title: String
}

enum AgoraLanguage: String, CaseIterable {
    case english    = "en-US"   // English - US
    case englishIn  = "en-IN"   // English - India
    case japanese   = "ja-JP"   // Japanese - Japan
    case chinese    = "zh-CN"   // Chiness - China Mainland
    case chineseTw  = "zh-TW"   // Chinese - Taiwanese Putonghua
    case Cantonese  = "zh-HK"   // Chinese - Cantonese, Traditional
    case hindi      = "hi-IN"   // Hindi = India
    case korean     = "ko-KR"   // Korean - South Korea
    case German     = "de-DE"   // German - Germany
    case Spanish    = "es-ES"   // Spanish - Spain
    case French     = "fr-FR"   // French = France
    case Italian    = "it-IT"   // Italian - Italy
    case Portuguese = "pt-PT"   // Portuguese - Portugal
    case Indonesian = "id-ID"   // Indonesian - Indonesia
    case Arabic_JO  = "ar-JO"   // Arabic - Jordan
    case Arabic_EG  = "ar-EG"   // Arabic - Egyptian
    case Arabic_SA  = "ar-SA"   // Arabic - Saudi Arabia
    case Arabic_AE  = "ar-AE"   // Arabic - United Arab Emirates
    case Turkish    = "tr-TR"   // Turkish
    /// 越南
    case Vietnamese = "vi-VN"
    /// 泰国
    case Thai       = "th-TH"
    /// 俄语
    case ru         = "ru-RU"
}


protocol SettingVCDelegate: NSObjectProtocol {
    func settingVCDidCompleted(appConfig: AppConfig)
}

class SettingVC: UIViewController {
    private let tableview = UITableView(frame: .zero, style: .grouped)
    private let button = UIButton()
    private var list = [Section]()
    weak var delegate: SettingVCDelegate?
    var appConfig = AppConfig.share.copyThis()
    fileprivate var currentSettingIndexPatn = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createData()
        setupUI()
        commonInit()
    }
    
    func createData() {
        list = [Section(title: "语言", rows: [.init(title: "转写目标语言"),
                                            .init(title: "翻译目标语言")]),
                Section(title: "server env", rows: [.init(title: "地址")])]
    }
    
    func setupUI() {
        title = "参数配置"
        button.setTitle("确 定", for: .normal)
        button.backgroundColor = .red
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
        button.addTarget(self, action: #selector(buttonTap(_:)), for: .touchUpInside)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.dataSource = self
        tableview.delegate = self
        tableview.reloadData()
    }
    
    @objc func buttonTap(_ sender: UIButton) {
        delegate?.settingVCDidCompleted(appConfig: appConfig)
        dismiss(animated: true)
    }
    
    func configCell(indexPath: IndexPath, cell: UITableViewCell) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.detailTextLabel?.text = appConfig.transcriptLangs.map({ $0.rawValue }).joined(separator: "/")
            }
            
            if indexPath.row == 1 {
                cell.detailTextLabel?.text = appConfig.translateLangs.map({ $0.rawValue }).joined(separator: "/")
            }
        }
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {

                cell.detailTextLabel?.text = appConfig.serverEnv.name
            }
        }
    }
}

extension SettingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return list[section].title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        let item = list[indexPath.section].rows[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = .disclosureIndicator

        cell.detailTextLabel?.textColor = .red
        configCell(indexPath: indexPath, cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        currentSettingIndexPatn = indexPath
        if indexPath.section == 0, indexPath.row == 0 {
            let vc = LanguageSelectedVC()
            vc.isMutiSelect = true
            vc.delegate = self
            present(vc, animated: true)
        }
        if indexPath.section == 0, indexPath.row == 1 {
            let vc = LanguageSelectedVC()
            vc.isMutiSelect = true
            vc.delegate = self
            present(vc, animated: true)
        }
        if indexPath.row == 0, indexPath.section == 1 {
            let vc = ServerEnvSelectedVC()
            vc.delegate = self
            present(vc, animated: true)
        }
    }
}

extension SettingVC: LanguageSelectedVCDelegate, ServerEnvSelectedVCDelegate {
    func languageSelectedVCDidSelected(langs: [AgoraLanguage]) {
        if currentSettingIndexPatn.row == 0, currentSettingIndexPatn.section == 0 {
            appConfig.transcriptLangs = langs
        }
        if currentSettingIndexPatn.row == 1, currentSettingIndexPatn.section == 0 {
            appConfig.translateLangs = langs
        }
        tableview.reloadData()
    }
    
    func serverEnvDidSelected(env: ServerEnv) {
        appConfig.serverEnv = env
        tableview.reloadData()
    }
}
