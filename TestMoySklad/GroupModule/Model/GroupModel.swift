//
//  GroupModel.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 09/05/2025.
//

import Foundation

// MARK: - GroupModel
struct GroupModel: Codable {
    let rows: [Row]
    
    //MARK: Row
    struct Row: Codable {
        let meta: MiniatureClass
    }
    
    // MARK: - MiniatureClass
    struct MiniatureClass: Codable {
        let downloadHref: String?
    }
}

