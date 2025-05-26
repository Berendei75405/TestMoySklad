//
//  FirstScreenViewModel.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 30/03/2025.
//

import Foundation

final class FirstScreenViewModel: ObservableObject {
    
    //dependences
    let keychainManager: KeychainManagerProtocol!
    
    //init
    init(keychainManager: KeychainManagerProtocol) {
        self.keychainManager = keychainManager
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
        } catch let networkError as NetworkError {
            print(networkError)
            return nil
        } catch {
            print(error)
            return nil
        }
    }
}
