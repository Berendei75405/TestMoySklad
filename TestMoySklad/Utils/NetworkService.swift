//
//  NetworkService.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 18/03/2025.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func executeRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    //MARK: - executeRequest
    func executeRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            //обработанная ошибка
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 300..<400:
                    return completion(.failure(.theRequestedResourceMoved))
                case 400..<500:
                    return completion(.failure(.invalidSyntaxOrCannotBeExecuted))
                case 500..<600:
                    return completion(.failure(.serverError))
                default:
                    break
                }
            }
            
            //необработанная ошибка
            if let error = error {
                completion(.failure(.error(error)))
                print(error)
            }
            
            //обработка успешного ответа
            if let data = data {
                DispatchQueue.main.async {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let decodedData = try decoder.decode(T.self, from: data)
                        
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(.error(error)))
                    }                    
                }
            }
        }
        
        //отправляем запрос
        task.resume()
    }
}

