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
    
    //constants
    let colomns: [GridItem] = [GridItem(.flexible(), spacing: 20),
                               GridItem(.flexible())]
    
    //states
    @State private var currentIndex = 0
    
    //MARK: - init
    init(viewModel: TobaccoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: colomns,
                      alignment: .center,
                      spacing: 20,
                      pinnedViews: [.sectionHeaders],
                      content: {
                productSection
            })
            .padding(.horizontal, 16)
        }
        .background(Color("background"))
        //при запуске
        .onAppear {
            Task {
               // await viewModel.getProduct()
            }
        }
    }
    
    var productSection: some View {
        Section {
            ForEach(0..<3, id: \.self) { index in
                ZStack() {
                    RoundedRectangle(cornerRadius: 10)
                        .fill((Color("background")))
                        .frame(height: 250)
                        .neumorphism(isSelected: false)
                    VStack {
                        TabView(selection: $currentIndex) {
//                            ForEach(viewModel.product?.rows[index])
//                            Image("mustHave")
//                                .resizable()
//                                .scaledToFit()
//                                .tag(index)
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .indexViewStyle(.page)
                        .clipShape(.rect(cornerRadius: 10))
                        .frame(height: 150)
                        .padding(.top, 8)
                        HStack {
                            ForEach(0..<3) { index in
                                Circle()
                                    .frame(height: index > 0 ? 5 : 10)
                            }
                        }
                        Text("\(viewModel.product?.rows[index].name ?? "Опись")")
                        Text("\(viewModel.product?.rows[index].salePrices[.zero].value ?? 0)")
                        Spacer()
                    }
                    .font(.title2)
                    .fontWeight(.light)
                    .foregroundColor(Color("other"))
                }
            }
        }
    }
    
    
}

#Preview {
    TobaccoView(viewModel: Factory.getTobaccoViewModel())
}
