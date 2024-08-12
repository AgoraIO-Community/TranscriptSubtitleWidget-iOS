//
//  ServerEnvSelectedVC.swift
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/7/9.
//

import UIKit

protocol ServerEnvSelectedVCDelegate: NSObjectProtocol {
    func serverEnvDidSelected(env: ServerEnv)
}

class ServerEnvSelectedVC: UIViewController {
    private let tableview = UITableView(frame: .zero, style: .grouped)
    private let addButton = UIButton()
    private var dataList = [[ServerEnv]]()
    private var selectedIndexs = [Int]()
    weak var delegate: ServerEnvSelectedVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        commonInit()
    }
    
    func setupUI() {
        addButton.setTitle("Add a customized Env", for: .normal)
        addButton.setTitleColor(.blue, for: .normal)
        view.backgroundColor = .white
        view.addSubview(tableview)
        view.addSubview(addButton)
        
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.topAnchor.constraint(equalTo: tableview.bottomAnchor).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func commonInit() {
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.dataSource = self
        tableview.delegate = self
        let customEnvs = EnvLocalSaveManager.shared.readCustomServerEnvs()
        dataList = [KeyCenter.serverEnvs, customEnvs]
        tableview.reloadData()
        
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
    }
    
    @objc func addButtonClicked() {
        let vc = AddEnvVC()
        vc.delegate = self
        present(vc, animated: true)
    }
}

extension ServerEnvSelectedVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "default envs" : "custom envs"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataList[indexPath.section][indexPath.row].name + "\n" + dataList[indexPath.section][indexPath.row].serverUrlString
        cell.textLabel?.numberOfLines = 0
        selectedIndexs.contains(indexPath.row) ? (cell.accessoryType = .checkmark) : (cell.accessoryType = .none)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let env = dataList[indexPath.section][indexPath.row]
        delegate?.serverEnvDidSelected(env: env)
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return indexPath.section == 1 ? .delete : .none
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            EnvLocalSaveManager.shared.deleteCustomServerEnv(index: indexPath.row)
            dataList[1] = EnvLocalSaveManager.shared.readCustomServerEnvs()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension ServerEnvSelectedVC: AddEnvVCDelegate {
    func addEnvVCDidAddEnv(env: ServerEnv) {
        EnvLocalSaveManager.shared.addCustomServerEnv(env: env)
        dataList[1] = EnvLocalSaveManager.shared.readCustomServerEnvs()
        tableview.reloadData()
    }
}
