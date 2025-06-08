//
//  TestMoySkladApp.swift
//  TestMoySklad
//
//  Created by Novgorodcev on 18/03/2025.
//

import SwiftUI

@main
struct TestMoySkladApp: App {
    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
                FirstScreen(viewModel: Factory.getFirstScreenViewModel())
                    .environment(\.mainWindowSize, proxy.size)
            }
        }
    }
}
