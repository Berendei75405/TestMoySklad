//
//  GroupViewModel.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 04/05/2025.
//

import Foundation
import Combine


final class GroupViewModel: ObservableObject {
    
    //dependences
    let networkManager: NetworkManagerProtocol!
    let keychainManager: KeychainManagerProtocol!
    
    //init
    init(networkManager: NetworkManagerProtocol,
         keychainManager: KeychainManagerProtocol) {
        self.networkManager = networkManager
        self.keychainManager = keychainManager
    }
    
    //Published var
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var product: Product?
    @Published var groupNameArray: [String] = []
    @Published var groupImages: [Data?] = []
    
    //MARK: - getGroupModel
    func getGroupModel() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        do {
            await updateToken()
            let token = getToken()
            let product = try await networkManager.getProduct(token: token)
            await getImages(product: product)
            await MainActor.run {
                self.product = product
                isLoading = false
            }
        } catch let networkError as NetworkError {
            showError(error: networkError.description)
        } catch {
            showError(error: error.localizedDescription)
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
            showError(error: keychainError.description)
            return keychainError.description
        } catch {
            showError(error: error.localizedDescription)
            return error.localizedDescription
        }
    }
    
    //MARK: - updateToken
    private func updateToken() async {
        //получение из keychainManager логин и пароль
        guard let username: String = try? keychainManager.retrieveItem(ofClass: .generic, key: "Login") else { return }
        guard let password: String = try? keychainManager.retrieveItem(ofClass: .generic, key: "Password") else { return }
        
        //обновляем токен на новый
        do {
            let newToken = try await networkManager.getAccessToken(username: username, password: password).accessToken
            try keychainManager.updateItem(with: newToken, ofClass: .generic, key: "ApiToken")
        } catch let networkError as NetworkError {
            showError(error: networkError.description)
        } catch {
            showError(error: error.localizedDescription)
        }
    }
    
    //MARK: - showError
    private func showError(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.errorMessage = error
            self?.isLoading = false
        }
    }
    
    //MARK: - filterGroupName
    private func filterGroupName(product: Product) -> [String] {
        var arrayURLS: [String] = []
        for row in product.rows {
            if !arrayURLS.contains(row.pathName) {
                arrayURLS.append(row.pathName)
            }
        }
        return arrayURLS
    }
    
    //MARK: - getImages
    private func getImages(product: Product) async {
        var urlArray: [String] = []
        let groupNameArray: [String] = filterGroupName(product: product)
        for item in groupNameArray {
            let imageURL = product.rows.first(where: {$0.pathName == item})?.images.meta.href ?? ""
            urlArray.append(imageURL)
        }
        
        do {
            try await downloadImages(from: urlArray)
            await MainActor.run {
                self.groupNameArray = groupNameArray
            }
        } catch let networkError as NetworkError {
            showError(error: networkError.description)
        } catch {
            showError(error: error.localizedDescription)
        }
    }
    
    //MARK: - downloadImages
    private func downloadImages(from urls: [String]) async throws {
        //до начала загрузки фотографий, получим наш токен
        let token = getToken()
        //для ссылки на фото
        var urlArray = [String]()
        var imagesArray: [Data?] = Array(repeating: nil, count: urls.count)
        
        //получаем ссылку на image
        for index in 0..<urls.count {
            do {
                let downloadHref = try await networkManager.getGroup(url: urls[index], token: token).rows[.zero].meta.downloadHref ?? ""
                urlArray.append(downloadHref)
            } catch let networkError as NetworkError {
                showError(error: networkError.description)
            } catch {
                showError(error: error.localizedDescription)
            }
        }
    
        //Получаем картинки
        for index in 0..<urlArray.count {
            do {
                imagesArray[index] = try await networkManager.loadImage(from: urlArray[index], token: token)
            } catch let networkError as NetworkError {
                showError(error: networkError.description)
            } catch {
                showError(error: error.localizedDescription)
            }
        }
        await MainActor.run { [imagesArray] in
            groupImages = imagesArray
        }
    }
}
