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
    
    //init
    init(keychainManager: KeychainManagerProtocol,
         networkManager: NetworkManagerProtocol) {
        self.keychainManager = keychainManager
        self.networkManager = networkManager
    }
}
