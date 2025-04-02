//
//  TobaccoViewModel.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 30/03/2025.
//

import Foundation

final class TobaccoViewModel: ObservableObject {
    
    //dependences
    let keychainManager: KeychainManagerProtocol!
    let networkManager: NetworkManagerProtocol!
    
    //published
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    //init
    init(keychainManager: KeychainManagerProtocol,
         networkManager: NetworkManagerProtocol) {
        self.keychainManager = keychainManager
        self.networkManager = networkManager
    }
    
    //MARK: - getProduct
    func getProduct() {
//        let token = getToken()
//        networkManager.getProducts(token: token) { [weak self] result in
//            switch result {
//            case .success(let product):
//                print(product)
//            case .failure(let error):
//                print(error)
//                DispatchQueue.main.async {
//                    self?.errorMessage = error.description                    
//                }
//                switch error {
//                case .invalidSyntaxOrCannotBeExecuted:
//                    self?.updateToken()
//                default:
//                    break
//                }
//            }
       // }
    }
    
    //MARK: - getToken
    private func getToken() -> String {
        do {
            let key = "ApiToken"
            keychainManager.attributes = [
                kSecAttrLabel: key
            ]
            
            let token: String = try keychainManager.retrieveItem(ofClass: .generic,
                                                         key: key)
            return token
        } catch let keychainError as KeychainError {
            return keychainError.description
        } catch {
            return error.localizedDescription
        }
    }
    
    //MARK: - updateToken
    func updateToken() {
//        guard let login: String = try? keychainManager.retrieveItem(ofClass: .generic, key: "Login") else { return }
//        guard let password: String = try? keychainManager.retrieveItem(ofClass: .generic, key: "Password") else { return }
//        networkManager.getAccessToken(username: login, password: password) { [weak self] result in
//            switch result {
//            case .success(let token):
//                try? self?.keychainManager.updateItem(with: token.accessToken, ofClass: .generic, key: "ApiToken")
//            case .failure(let error):
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                    self?.errorMessage = error.localizedDescription
//                }
//            }
//            self?.isLoading = false
//        }
    }
}
