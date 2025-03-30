//
//  Extensions.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 29/03/2025.
//

import SwiftUI

//MARK: - Neumorphism
extension View {
    func neumorphism(isSelected: Bool, shadowRadius: CGFloat = 5, shadowOffset: CGFloat = 5, lightShadowColor: Color = Color("lightShadow"), darkShadowColor: Color = Color("darkShadow")) -> some View {
        modifier(NeumorphismStyle(isSelected: isSelected, shadowRadius: shadowRadius, shadowOffset: shadowOffset, lightShadowColor: lightShadowColor, darkShadowColor: darkShadowColor))
    }
}

//MARK: - NetworkError
enum NetworkError: Error {
    case errorWithDescription(String)
    case error(Error)
}
