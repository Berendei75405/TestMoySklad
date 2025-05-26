//
//  NetworkManager.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 18/03/2025.
//

import Foundation

protocol NetworkManagerProtocol: AnyObject {
    func getAccessToken(username: String,
                        password: String) async throws -> AccessToken
    func getProduct(token: String) async throws -> Product
    func getGroup(url: String, token: String) async throws -> GroupModel
    func loadImage(from url: String, token: String) async throws -> Data
}

final class NetworkManager: NetworkManagerProtocol {
    
    var networkService: NetworkServiceProtocol!
    
    //MARK: - init
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    //MARK: - getAccessToken
    func getAccessToken(username: String,
                        password: String) async throws -> AccessToken {
        let loginString = "\(username):\(password)".data(using: .utf8)?.base64EncodedString()
        
        guard let loginString = loginString else {
            print("Error encoding username and password")
            throw NetworkError.invalidLoginOrPassword
        }
        
        guard let url = URL(string: "https://api.moysklad.ru/api/remap/1.2/security/token") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Basic \(loginString)", forHTTPHeaderField: "Authorization")
        
        return try await networkService.executeRequest(request: request)
    }
    
    //MARK: - getProduct
    func getProduct(token: String) async throws -> Product {
        guard let url = URL(string: "https://api.moysklad.ru/api/remap/1.2/entity/product") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return try await networkService.executeRequest(request: request)
    }
    
    //MARK: - loadImage
    func loadImage(from url: String, token: String) async throws -> Data {
        guard let url = URL(string: url) else { throw NetworkError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return try await networkService.executeRequest(request: request)
    }
    
    func getGroup(url: String,
                  token: String) async throws -> GroupModel {
        guard let url = URL(string: url) else { throw NetworkError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return try await networkService.executeRequest(request: request)
    }
    
}
