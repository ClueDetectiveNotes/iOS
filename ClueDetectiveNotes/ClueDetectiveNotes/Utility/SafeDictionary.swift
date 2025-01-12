//
//  SafeDictionary.swift
//  ClueDetectiveNotes
//
//  Created by MARY on 1/12/25.
//

final class SafeDictionary {
    private var dic: [String: String] = [:]
    private let rtnMsg = " is not exist."
    
    func putString(key: String, value: String) {
        dic[key] = value
    }
    
    func getString(key: String) -> String {
        if let value = dic[key] {
            return value
        } else {
            return key + rtnMsg
        }
    }
}
