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
    
    //init
    init(keychainManager: KeychainManagerProtocol,
         networkManager: NetworkManagerProtocol) {
        self.keychainManager = keychainManager
        self.networkManager = networkManager
    }
    
    //MARK: - getProduct
    func getProduct() {
        let token = getToken()
        networkManager.getProducts(token: token) { [weak self] result in
            switch result {
            case .success(let product):
                print(product)
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
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
}
