//
//  NetworkService.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 18/03/2025.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func executeRequest<T: Decodable>(request: URLRequest) async throws -> T
    func executeRequest(request: URLRequest) async throws -> Data
}

final class NetworkService: NetworkServiceProtocol {
    
    //MARK: - executeRequest
    func executeRequest<T: Decodable>(request: URLRequest) async throws -> T {
        //декодер
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        //проверяем есть ли кеш по запросу, если нету, то отправляем запрос
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            do {
                return try decoder.decode(T.self, from: cachedResponse.data)
            }
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknownError
            }
            
            //обработка ошибок
            switch httpResponse.statusCode {
            case 300..<400:
                throw NetworkError.theRequestedResourceMoved
            case 400..<500:
                throw NetworkError.invalidSyntaxOrCannotBeExecuted
            case 500..<600:
                throw NetworkError.serverError
            default:
                break
            }
            
            do {
                //кеширование
                let cachedResponse = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedResponse, for: request)
                
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.error(error)
            }
        } catch {
            if let error = error as? URLError {
                throw NetworkError.error(error)
            } else if let error = error as? NetworkError {
                throw error
            } else {
                throw NetworkError.error(error)
            }
        }
    }
    
    ///Получение Data
    func executeRequest(request: URLRequest) async throws -> Data {
        //декодер
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        //проверяем есть ли кеш по запросу, если нету, то отправляем запрос
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            do {
                return cachedResponse.data
            }
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknownError
            }
            
            //обработка ошибок
            switch httpResponse.statusCode {
            case 300..<400:
                throw NetworkError.theRequestedResourceMoved
            case 400..<500:
                throw NetworkError.invalidSyntaxOrCannotBeExecuted
            case 500..<600:
                throw NetworkError.serverError
            default:
                break
            }
            //кеширование
            let cachedResponse = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedResponse, for: request)
            
            return data
        }
    }
}
