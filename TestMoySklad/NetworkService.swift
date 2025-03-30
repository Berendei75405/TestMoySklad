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
                    return completion(.failure(.errorWithDescription("Запрошенный ресурс перемещен в другое место.")))
                case 400..<500:
                    return completion(.failure(.errorWithDescription("Запрос содержит неверный синтаксис или не может быть выполнен.")))
                case 500..<600:
                    return completion(.failure(.errorWithDescription("Сервер не смог выполнить запрос.")))
                default:
                    break
                }
            }
            
            //необработанная ошибка
            if let error = error {
                completion(.failure(.errorWithDescription("Возникла непредвиденная ошибка или отсутствует соединение с интернетом")))
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
                        completion(.failure(.errorWithDescription("\(error)")))
                    }                    
                }
            }
        }
        
        //отправляем запрос
        task.resume()
    }
}

