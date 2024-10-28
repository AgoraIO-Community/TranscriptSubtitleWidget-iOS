//
//  FileReader.swift
//  AgoraRTT_Demo
//
//  Created by ZYP on 2024/7/12.
//

import Foundation

class FileReader {
    static func fetch(fileName: String) -> [Data] {
        let path = Bundle.main.path(forResource: fileName, ofType: nil)!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let string = String(data: data, encoding: .utf8)!
        
        let datas = string.split(separator: "\n")
        let separator = "data:"
        if datas.count > 2 {
            return datas
                .map({ String($0) })
                .filter({ !$0.isEmpty })
                .map({ string in
                    if string.contains(separator) {
                        return String(string.components(separatedBy: separator).last!)
                    }
                    else {
                        return string
                    }
                })
                .map({ Data(base64Encoded: $0)! })
        }
        else {
            return string.split(separator: "\r\n")
                .map({ String($0) })
                .filter({ !$0.isEmpty })
                .map({ string in
                    if string.contains(separator) {
                        return String(string.components(separatedBy: separator).last!)
                    }
                    else {
                        return string
                    }
                })
                .map({ Data(base64Encoded: $0)! })
        }
    }
}


