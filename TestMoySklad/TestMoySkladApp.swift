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
            FirstScreen(viewModel: Factory.getFirstScreenViewModel())
        }
    }
}
