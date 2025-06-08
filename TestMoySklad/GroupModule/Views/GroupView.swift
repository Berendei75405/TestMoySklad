//
//  Group.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 03/05/2025.
//

import SwiftUI

struct GroupView: View {
    //constants
    let colomns: [GridItem] = [GridItem(.flexible(), spacing: 20),
                               GridItem(.flexible())]
    
    //states
    @State private var currentIndex = 0
    
    //observedObjects
    @ObservedObject var viewModel: GroupViewModel
    
    //MARK: - init
    init(viewModel: GroupViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack {
                    Text("Категории товаров")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("other"))
                        .padding(.top, 16)
                }
                LazyVGrid(columns: colomns,
                          alignment: .center,
                          spacing: 20,
                          pinnedViews: [.sectionHeaders],
                          content: {
                    productSection
                })
                .padding(.horizontal, 16)
            }
            //загрузка
            LoadView(isLoading: $viewModel.isLoading)
            //показ ошибки
            ErrorView(showError: $viewModel.errorMessage)
        }
        //при запуске
        .onAppear {
            Task {
                await viewModel.getGroupModel()
            }
        }
        .background(Color("background"))
    }
    
    var productSection: some View {
        Section {
            ForEach(0..<viewModel.groupNameArray.count,
                    id: \.self) { index in
                ZStack() {
                    RoundedRectangle(cornerRadius: 10)
                        .fill((Color("background")))
                        .frame(height: 250)
                        .neumorphism(isSelected: false)
                    VStack {
                        Image(uiImage: imageFromData(from: viewModel.groupImages[index]))
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 10))
                            .frame(height: 150)
                            .padding(.all, 8)
                        Text("\(viewModel.groupNameArray[index])")
                            .font(.title2)
                            .fontWeight(.light)
                            .foregroundColor(Color("other"))
                            .padding(.top, 8)
                        Spacer()
                    }
                    .font(.title2)
                    .fontWeight(.light)
                    .foregroundColor(Color("other"))
                }
            }
        }
    }
    
    //MARK: - imageFromData
    private func imageFromData(from data: Data?) -> UIImage {
        let data = data ?? Data()
        let uiImage = (UIImage(data: data) ?? UIImage(systemName: "questionmark")) ?? UIImage()
        
        return uiImage
    }
}

#Preview {
    GeometryReader { proxy in
        GroupView(viewModel: Factory.getGroupViewModel())
            .environment(\.mainWindowSize, proxy.size)
    }
}
