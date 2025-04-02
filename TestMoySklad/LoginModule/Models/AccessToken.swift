//
//  AcessToken.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 19/03/2025.
//

import Foundation

struct AccessToken: Codable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
