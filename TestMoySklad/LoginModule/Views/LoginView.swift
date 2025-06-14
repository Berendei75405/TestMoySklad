//
//  ContentView.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 17/03/2025.
//

import SwiftUI

struct LoginView: View {
    //observedObjects
    @ObservedObject var viewModel: LoginViewModel
    
    //states
    @State private var loginText = ""
    @State private var passwordText = ""
    
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
                    Task {
                        await viewModel.fetchToken(login: loginText, password: passwordText)
                    }
                } label: {
                    Text("Войти")
                        .frame(width: 200, height: 50)
                        .background(Color("background"))
                        .clipShape(.buttonBorder)
                        .neumorphism(isSelected: false)
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
        //появление следующего экрана при удачной авторизации
        .fullScreenCover(isPresented: $viewModel.isShowScreen, content: {
            GroupView(viewModel: Factory.getGroupViewModel())
        })
        .background(Color("background"))
    }
    
    //MARK: - init
    init(viewModel: LoginViewModel) {
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
    LoginView(viewModel: Factory.getLoginViewModel())
}
