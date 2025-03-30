//
//  DependencyInjector.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 21/03/2025.
//

import Foundation

final class DependencyInjector: AnyObject {
    static func resolvePostViewModel() -> ViewModel {
        let networkService = NetworkService()
        let networkManager = NetworkManager(networkService: networkService)
        let keychainManager = KeychainManager()
//        let persistentContainer = NSPersistentContainer(name: "YourContainerName")
//        let coreDataManager = DefaultCoreDataManager(persistentContainer: persistentContainer)
        return ViewModel(networkManager: networkManager, keychainManager: keychainManager)
    }
}
