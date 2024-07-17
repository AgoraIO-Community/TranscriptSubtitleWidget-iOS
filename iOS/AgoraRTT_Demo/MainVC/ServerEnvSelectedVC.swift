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

class ServerEnvSelectedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableview = UITableView(frame: .zero, style: .grouped)
    private var dataList = [ServerEnv]()
    private var selectedIndexs = [Int]()
    weak var delegate: ServerEnvSelectedVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        commonInit()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableview)
        
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
    }
    
    func commonInit() {
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.dataSource = self
        tableview.delegate = self
        dataList = KeyCenter.serverEnvs
        tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataList[indexPath.row].name + "\n" + dataList[indexPath.row].serverUrlString
        cell.textLabel?.numberOfLines = 0
        selectedIndexs.contains(indexPath.row) ? (cell.accessoryType = .checkmark) : (cell.accessoryType = .none)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let env = dataList[indexPath.row]
        delegate?.serverEnvDidSelected(env: env)
        dismiss(animated: true)
    }

}
