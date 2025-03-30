//
//  KeychainUtils.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 29/03/2025.
//


import Foundation

public typealias KeychainDictionary = [String : Any]
public typealias ItemAttributes = [CFString : Any]

extension KeychainDictionary {
    mutating func addAttributes(_ attributes: ItemAttributes) {
        for(key, value) in attributes {
            self[key as String] = value
        }
    }
}
