//
//  DependencyInjector.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 21/03/2025.
//

import Foundation

final class Factory: AnyObject {
    //MARK: - resolvePostViewModel
    static func getLoginViewModel() -> LoginViewModel {
        let networkService = NetworkService()
        let networkManager = NetworkManager(networkService: networkService)
        let keychainManager = KeychainManager()
        
        return LoginViewModel(networkManager: networkManager, keychainManager: keychainManager)
    }
    
    //MARK: - getFirstScreenViewModel
    static func getFirstScreenViewModel() -> FirstScreenViewModel {
        let keychainManager = KeychainManager()
        
        return FirstScreenViewModel(keychainManager: keychainManager)
    }
    
    //MARK: - getTobaccoViewModel
    static func getTobaccoViewModel() -> TobaccoViewModel {
        let keychainManager = KeychainManager()
        let networkService = NetworkService()
        let networkManager = NetworkManager(networkService: networkService)
        
        return TobaccoViewModel(keychainManager: keychainManager,
                                networkManager: networkManager)
    }
    
    //MARK: - getGroupViewModel
    static func getGroupViewModel() -> GroupViewModel {
        let keychainManager = KeychainManager()
        let networkService = NetworkService()
        let networkManager = NetworkManager(networkService: networkService)
        
        return GroupViewModel(networkManager: networkManager,
                              keychainManager: keychainManager)
    }
}
