//
//  FirstScreen.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 30/03/2025.
//

import SwiftUI

struct FirstScreen: View {
    //observedObjects
    @ObservedObject var viewModel: FirstScreenViewModel
    
    //init
    init(viewModel: FirstScreenViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if viewModel.checkToken() == nil {
            LoginView(viewModel: DependencyInjector.getLoginViewModel())
        } else {
            TobaccoView(viewModel: DependencyInjector.getTobaccoViewModel())
        }
    }
}

#Preview {
    FirstScreen(viewModel: DependencyInjector.getFirstScreenViewModel())
}
