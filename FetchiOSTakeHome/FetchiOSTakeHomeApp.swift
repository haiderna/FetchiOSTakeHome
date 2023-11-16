//
//  FetchiOSTakeHomeApp.swift
//  FetchiOSTakeHome
//
//  Created by Najia Haider on 11/4/23.
//

import SwiftUI

@main
struct FetchiOSTakeHomeApp: App {
    var body: some Scene {
        WindowGroup {
            DessertView(viewModel: DessertViewModel())
        }
    }
}
