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
    @Published var product: Product?
    
    //init
    init(keychainManager: KeychainManagerProtocol,
         networkManager: NetworkManagerProtocol) {
        self.keychainManager = keychainManager
        self.networkManager = networkManager
    }
    
//    //MARK: - getProduct
//    func getProduct() async {
//        do {
//            await updateToken()
//            let token = getToken()
//            let product = try await networkManager.getProducts(token: token)
//            await MainActor.run {
//                self.product = product
//            }
//        } catch let networkError as NetworkError {
//            showError(error: networkError.description)
//        } catch {
//            showError(error: error.localizedDescription)
//        }
//    }
//    
//    //MARK: - getToken
//    private func getToken() -> String {
//        do {
//            let key = "ApiToken"
//            keychainManager.attributes = [
//                kSecAttrLabel: key
//            ]
//            
//            let token: String = try keychainManager.retrieveItem(ofClass: .generic,
//                                                                 key: key)
//            return token
//        } catch let keychainError as KeychainError {
//            return keychainError.description
//        } catch {
//            return error.localizedDescription
//        }
//    }
//    
//    //MARK: - updateToken
//    private func updateToken() async {
//        //получение из keychainManager логин и пароль
//        guard let username: String = try? keychainManager.retrieveItem(ofClass: .generic, key: "Login") else { return }
//        guard let password: String = try? keychainManager.retrieveItem(ofClass: .generic, key: "Password") else { return }
//        
//        //обновляем токен на новый
//        do {
//            let newToken = try await networkManager.getAccessToken(username: username, password: password).accessToken
//            try keychainManager.updateItem(with: newToken, ofClass: .generic, key: "ApiToken")
//        } catch let networkError as NetworkError {
//            showError(error: networkError.description)
//        } catch {
//            showError(error: error.localizedDescription)
//        }
//    }
//    
//    //MARK: - showError
//    private func showError(error: String) {
//        DispatchQueue.main.async { [weak self] in
//            self?.errorMessage = error
//            self?.isLoading = false
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: { [weak self] in
//            self?.errorMessage = nil
//        })
//    }
}
