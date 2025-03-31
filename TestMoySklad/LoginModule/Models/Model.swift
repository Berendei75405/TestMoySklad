//
//  Model.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 19/03/2025.
//

import Foundation

//MARK: - Product
struct Product: Codable {
    let rows: [Row]
}

//MARK: - Employee
struct Employee: Codable {
    let meta: EmployeeMeta
}

//MARK: - EmployeeMeta
struct EmployeeMeta: Codable {
    let href: String
    let metadataHref: String?
    let type: String
    let mediaType: MediaType
    let uuidHref: String?
}

enum MediaType: String, Codable {
    case applicationJSON = "application/json"
}

//MARK: - ProductMeta
struct ProductMeta: Codable {
    let href: String
    let type: String
    let mediaType: MediaType
    let size, limit, offset: Int
}

//MARK: - Row
struct Row: Codable {
    let updated, name: String
    let description: String?
    let images: Files
    let salePrices: [SalePrice]
    let weight, volume: Int
    let minimumBalance: Int?
    let article: String?
    let tobacco: Bool?

    enum CodingKeys: String, CodingKey {
        case updated, name, description, images, salePrices, weight, volume, minimumBalance, article, tobacco
    }
}

//MARK: - Barcode
struct Barcode: Codable {
    let ean13: String
}

//MARK: - Price
struct Price: Codable {
    let value: Int
    let currency: Employee
}

//MARK: - Files
struct Files: Codable {
    let meta: ProductMeta
}

//MARK: - SalePrice
struct SalePrice: Codable {
    let value: Int
    let currency: Employee
    let priceType: PriceType
}

//MARK: - PriceType
struct PriceType: Codable {
    let meta: EmployeeMeta
    let id, name, externalCode: String
}

