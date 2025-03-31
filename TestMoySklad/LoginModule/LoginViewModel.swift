//
//  ViewModel.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 17/03/2025.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    
    //constants
    let username = "admin@73novgor"
    let password  = "Golyb138@"
    
    //dependences
    let networkManager: NetworkManagerProtocol!
    let keychainManager: KeychainManagerProtocol!
    
    //Published var
    @Published var products: Product?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - init
    init(networkManager: NetworkManagerProtocol,
         keychainManager: KeychainManagerProtocol) {
        self.networkManager = networkManager
        self.keychainManager = keychainManager
    }
    
    //MARK: - fetchToken
    func fetchToken(login: String, password: String) {
        isLoading = true
        if login == username && password == self.password {
            errorMessage = nil
            getAccessToken()
        } else {
            errorMessage = "Неправильно введен логин или пароль!"
            isLoading = false
            //время через которое уберется ошибка
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.errorMessage = nil
            }
        }
    }
    
    //MARK: - getAccessToken
    private func getAccessToken() {
        networkManager.getAccessToken(username: username, password: password) { [weak self] result in
            switch result {
            case .success(let token):
                self?.saveToken(token: token.accessToken)
            case .failure(let error):
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self?.errorMessage = error.localizedDescription
                }
            }
            self?.isLoading = false
        }
    }
    
    //MARK: - saveToken
    private func saveToken(token: String) {
        do {
            let key = "ApiToken"
            keychainManager.attributes = [
                kSecAttrLabel: key
            ]
            
            try keychainManager.saveItem(token, itemClass: .generic, key: key)
        } catch let keychainError as KeychainError {
            self.errorMessage = keychainError.description
        } catch {
            self.errorMessage = error.localizedDescription
        }
        //время через которое уберется ошибка
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.errorMessage = nil
        }
    }
}
