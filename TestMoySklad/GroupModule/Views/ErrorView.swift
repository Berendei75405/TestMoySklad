//
//  ErrorView.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 29/05/2025.
//

import SwiftUI

//MARK: - ErrorViewProtocol
protocol ErrorViewProtocol: AnyObject {
    
}

struct ErrorView: View {
    
    //binding
    @Binding var showError: String?
    
    //environments
    @Environment(\.mainWindowSize) var size
    
    var body: some View {
        if showError != nil {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("background"))
                    .neumorphism(isSelected: false)
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color("background"))
                                    .frame(width: 50, height: 50)
                                    .padding(.all, 8)
                                    .neumorphism(isSelected: false)
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.other)
                            }
                        }
                    }
                    Spacer()
                }
                Text("\(showError ?? "")")
                    .font(.title)
                    .foregroundStyle(Color("other"))
                    .padding(.all, 8)
            }
            .frame(height: size.height / 2)
            .padding(.horizontal, 32)
        }
    }
}

#Preview {
    GeometryReader { proxy in
        var bool = "nil"
        ErrorView(showError: Binding(get: {
            bool
        }, set: { _ in
            bool = ""
        }))
        .environment(\.mainWindowSize, proxy.size)
    }
}
