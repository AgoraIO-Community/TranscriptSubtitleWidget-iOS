//
//  MainVC+Debug.swift
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/7/12.
//

import SVProgressHUD

extension MainVC {
    func debug_replay() {
        DispatchQueue.global().async {
            let datas = FileReader.fetch(fileName: "dataStreamResults13.txt")
            for (index, data) in datas.enumerated() {
                DispatchQueue.main.async {
                    self.mainView.rttView.pushMessageData(data: data, uid: 0)
                    SVProgressHUD.showInfo(withStatus: "\(index)")
                }
//                Thread.sleep(forTimeInterval: 0.35)
            }
        }
    }
}
