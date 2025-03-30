//
//  Modifiers.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 29/03/2025.
//

import SwiftUI

struct NeumorphismStyle: ViewModifier {
    var isSelected: Bool
    var shadowRadius: CGFloat = 5
    var shadowOffset: CGFloat = 5
    var lightShadowColor: Color = Color("lightShadow")
    var darkShadowColor: Color = Color("darkShadow")
    
    func body(content: Content) -> some View {
        content
            .shadow(color: lightShadowColor, radius: shadowRadius, x: isSelected ? shadowOffset : -shadowOffset, y: isSelected ? shadowOffset : -shadowOffset)
            .shadow(color: darkShadowColor, radius: shadowRadius, x: isSelected ? -shadowOffset : shadowOffset, y: isSelected ? -shadowOffset : shadowOffset)
    }
}
