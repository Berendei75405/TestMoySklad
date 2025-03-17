//
//  Item.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 17/03/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
