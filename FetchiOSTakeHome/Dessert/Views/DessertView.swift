//
//  DessertView.swift
//  FetchiOSTakeHome
//
//  Created by Najia Haider on 11/4/23.
//

import SwiftUI

struct DessertView: View {
    
    private let cols = Array(repeating: GridItem(.flexible()), count: 2)
    
    @StateObject var viewModel = DessertViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: cols, spacing: 16) {
                            ForEach(viewModel.desserts, id: \.idMeal) { item in
                                NavigationLink {
                                    MealDetailView(id: item.idMeal)
                                } label: {
                                    DessertListItem(dessert: item)
                                        .accessibilityLabel("\(item.strMeal)")
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .task {
                await viewModel.getDesserts()
            }
            .alert("Error", isPresented: $viewModel.showErrorAlert, actions: {
                tryAgainAlertButton
            }, message: {
                Text(viewModel.error?.localizedDescription ?? "Unrecognized Error")
            })
            
            .navigationTitle("Desserts")
            .accessibilityLabel("Desserts List")
        }
    }
}

struct DessertView_Previews: PreviewProvider {
    static var previews: some View {
        DessertView()
    }
}

extension DessertView {
    
    // ALERT UI
    
    @ViewBuilder
    var tryAgainAlertButton: some View {
        Button("Try Again") {
            Task {
                await viewModel.getDesserts()
            }
        }
    }
}
