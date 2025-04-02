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
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isShowScreen = false
    
    //MARK: - init
    init(networkManager: NetworkManagerProtocol,
         keychainManager: KeychainManagerProtocol) {
        self.networkManager = networkManager
        self.keychainManager = keychainManager
        saveLoginAndPassword()
    }
    
    //MARK: - fetchToken
    func fetchToken(login: String, password: String) async {
        await MainActor.run {
            self.isLoading = true
        }
        if login == username && password == self.password {
            await MainActor.run {
                errorMessage = nil
            }
            do {
                try await getAccessToken()
            } catch let networkError as NetworkError {
                showError(error: networkError.description)
            } catch {
                showError(error: error.localizedDescription)
            }
        } else {
            showError(error: "Неправильный логин или пароль")
        }
    }
    
    //MARK: - getAccessToken
    private func getAccessToken() async throws {
        Task {
            do {
                let accessToken = try await networkManager.getAccessToken(username: username, password: password).accessToken
                await MainActor.run {
                    isShowScreen.toggle()
                }
                saveToken(token: accessToken)
            } catch let networkError as NetworkError {
                showError(error: networkError.description)
            } catch {
                showError(error: error.localizedDescription)
            }
            await MainActor.run {
                isLoading = false
            }
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
    }
    
    //MARK: - saveLoginAndPassword
    private func saveLoginAndPassword() {
        //save login
        do  {
            let key = "Login"
            keychainManager.attributes = [
                kSecAttrLabel: key
            ]
            
            try keychainManager.saveItem(username, itemClass: .generic, key: key)
        } catch let keychainError as KeychainError {
            print(keychainError)
        } catch {
            print(error)
        }
        
        //save password
        do  {
            let key = "Password"
            keychainManager.attributes = [
                kSecAttrLabel: key
            ]
            
            try keychainManager.saveItem(password, itemClass: .generic, key: key)
        } catch let keychainError as KeychainError {
            print(keychainError)
        } catch {
            print(error)
        }
    }
    
    //MARK: - checkToken
    func checkToken() -> String? {
        do {
            let key = "ApiToken"
            keychainManager.attributes = [
                kSecAttrLabel: key
            ]
            
            let token: String = try keychainManager.retrieveItem(ofClass: .generic, key: key)
            return token
        } catch {
            return nil
        }
    }
    
    //MARK: - showError
    private func showError(error: String) {
        errorMessage = error
        isLoading = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: { [weak self] in
            self?.errorMessage = nil
        })
    }
}
