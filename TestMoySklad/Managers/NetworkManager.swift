//
//  NetworkManager.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 18/03/2025.
//

import Foundation

protocol NetworkManagerProtocol: AnyObject {
    func getAccessToken(username: String,
                        password: String, completion: @escaping (Result<AccessToken, NetworkError>) -> Void)
    func getProducts(token: String, completion: @escaping (Result<Product, NetworkError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    var networkService: NetworkServiceProtocol!
    
    //MARK: - init
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    //MARK: - getAccessToken
    func getAccessToken(username: String,
                        password: String, completion: @escaping (Result<AccessToken, NetworkError>) -> Void) {
        let loginString = "\(username):\(password)".data(using: .utf8)?.base64EncodedString()
        
        guard let loginString = loginString else {
            print("Error encoding username and password")
            return
        }
        
        guard let url = URL(string: "https://api.moysklad.ru/api/remap/1.2/security/token") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Basic \(loginString)", forHTTPHeaderField: "Authorization")
        
        networkService.executeRequest(request: request, completion: completion)
    }
    
    //MARK: - getProducts
    func getProducts(token: String, completion: @escaping (Result<Product, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.moysklad.ru/api/remap/1.2/entity/product") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkService.executeRequest(request: request, completion: completion)
    }
    
}
