//
//  ContentView.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 17/03/2025.
//

import SwiftUI

struct ContentView: View {
    //observedObjects
    @ObservedObject var viewModel: ViewModel
    
    //states
    @State private var loginText = ""
    @State private var passwordText = ""
    @State private var enterState = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Spacer()
                Text("Введите данные")
                    .font(.custom("light", size: 26))
                    .padding(.bottom)
                TextField("Логин", text: $loginText)
                    .textFieldStyle(.roundedBorder)
                    .neumorphism(isSelected: false)
                TextField("Пароль", text: $passwordText)
                    .textFieldStyle(.roundedBorder)
                    .neumorphism(isSelected: false)
                Button {
                    viewModel.fetchToken(login: loginText, password: passwordText)
                    enterState.toggle()
                } label: {
                    Text("Войти")
                        .frame(width: 200, height: 50)
                        .background(Color("background"))
                        .clipShape(.buttonBorder)
                        .neumorphism(isSelected: enterState)
                        .padding(.top)
                }
                Spacer()
            }
            .font(.title2)
            .fontWeight(.light)
            .foregroundColor(Color("other"))
            .padding()
            errorView
            ProgressView()
                .opacity(viewModel.isLoading ? 1 : 0)
        }
        .background(Color("background"))
    }
    
    //MARK: - init
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    //MARK: - errorView
    private var errorView: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color("background"))
                Text("\(viewModel.errorMessage ?? "")")
                    .font(.title2)
                    .fontWeight(.light)
                    .foregroundColor(Color("other"))
            }
            .frame(height: 100)
            .neumorphism(isSelected: false)
        }
        .opacity(viewModel.errorMessage != nil ? 1 : .zero)
        .animation(.easeInOut(duration: 0.5), value: viewModel.errorMessage)
        .padding(.all, 16)
    }
    
}

#Preview {
    ContentView(viewModel: DependencyInjector.resolvePostViewModel())
}
