//
//  CustomTabView.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 04/04/2025.
//

import SwiftUI

struct PageControl: View {
    @Binding var currentIndex: Int
    let numberOfPages: Int
    
    private func isActive(index: Int) -> Bool {
        return index == currentIndex
    }
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(isActive(index: index) ? Color.blue : Color.gray.opacity(0.5))
            }
        }
    }
}
