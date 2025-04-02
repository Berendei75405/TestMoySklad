//
//  TobaccoView.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 30/03/2025.
//

import SwiftUI
import Combine

struct TobaccoView: View {
    //observedObjects
    @ObservedObject var viewModel: TobaccoViewModel
    
    //MARK: - init
    init(viewModel: TobaccoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            //при запуске
            .onAppear {
                //viewModel.getProduct()
            }
    }
}

#Preview {
    TobaccoView(viewModel: DependencyInjector.getTobaccoViewModel())
}
