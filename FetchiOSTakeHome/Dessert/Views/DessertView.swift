//
//  DessertView.swift
//  FetchiOSTakeHome
//
//  Created by Najia Haider on 11/4/23.
//

import SwiftUI

struct DessertView: View {
    @ObservedObject var viewModel: DessertViewModel
    
    private let cols = Array(repeating: GridItem(.flexible()), count: 2)
    
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
                                    MealDetailView(viewModel: MealDetailViewModel(),
                                                   id: item.idMeal)
                                } label: {
                                    DessertListItem(viewModel: DessertListItemViewModel(dessert: item))
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
        DessertView(viewModel: DessertViewModel(networkManager: NetworkDessertMock()))
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
