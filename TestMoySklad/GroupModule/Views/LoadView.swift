//
//  LoadView.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 28/05/2025.
//

import SwiftUI

struct LoadView: View {
    @Binding var isLoading: Bool
    
    var body: some View {
        withAnimation(.easeIn(duration: 1)) {
            HStack {
                ForEach(0...4, id: \.self) { index in
                    Circle()
                        .fill(Color("other"))
                        .neumorphism(isSelected: false)
                        .frame(width: 12, height: 12)
                        .scaleEffect(isLoading ? 0 : 1).animation(.linear(duration: 0.6).repeatForever().delay(0.2 * Double(index)), value: isLoading)
                }
            }
            .opacity(isLoading ? 1 : 0)
        }
    }
}
