//
//  Extensions.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 29/03/2025.
//

import SwiftUI

//MARK: - Environment
private struct MainWindowSizeKey: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

extension EnvironmentValues {
    var mainWindowSize: CGSize {
        get { self[MainWindowSizeKey.self] }
        set { self[MainWindowSizeKey.self] = newValue }
    }
}

//MARK: - Neumorphism
extension View {
    func neumorphism(isSelected: Bool, shadowRadius: CGFloat = 5, shadowOffset: CGFloat = 5, lightShadowColor: Color = Color("lightShadow"), darkShadowColor: Color = Color("darkShadow")) -> some View {
        modifier(NeumorphismStyle(isSelected: isSelected, shadowRadius: shadowRadius, shadowOffset: shadowOffset, lightShadowColor: lightShadowColor, darkShadowColor: darkShadowColor))
    }
}

//MARK: - NetworkError
enum NetworkError: Error {
    case theRequestedResourceMoved
    case invalidSyntaxOrCannotBeExecuted
    case serverError
    case unknownError
    case invalidURL
    case invalidLoginOrPassword
    case error(Error)
    
    var description: String {
        switch self {
        case .theRequestedResourceMoved:
            return "Запрошенный ресурс перемещен в другое место."
        case .invalidSyntaxOrCannotBeExecuted:
            return "Запрос содержит неверный синтаксис или не может быть выполнен."
        case .serverError:
            return "Сервер не смог выполнить запрос."
        case .unknownError:
            return "Возникла неизвестная ошибка"
        case .invalidURL:
            return "URL не действителен"
        case .invalidLoginOrPassword:
            return "Неправильный логин или пароль"
        case .error(let error):
            return "\(error.localizedDescription)"
        }
    }
}
