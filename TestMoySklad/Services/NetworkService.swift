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
            
            //декодирование
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
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
            
            return data
        }
    }
}
