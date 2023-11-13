//
//  MealDetailView.swift
//  FetchiOSTakeHome
//
//  Created by Najia Haider on 11/4/23.
//

import SwiftUI

struct MealDetailView: View {
    @StateObject var viewModel = MealDetailViewModel()
    let id: Int
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.white
            if viewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        title
                        image
                        ingredientsTitle
                            ForEach(viewModel.ingredientsList, id: \.self) { item in
                                    Text("• \(item)")
                            }
                        instructionsTitle
                        Text(viewModel.dessertInfo?.strInstructions ?? "*****")
                    }
                    .padding()
                }
            }
            
        }
        .task {
            await viewModel.fetchDessertInfo(id: id)
        }
        .alert("Error", isPresented: $viewModel.showErrorAlert, actions: {
            tryAgainAlertButton
            goBackAlertButton
        }, message: {
            Text(viewModel.error?.localizedDescription ?? "Unrecognized Error")
        })
        .navigationTitle("Recipe Details")
        
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(id: 1)
    }
}

extension MealDetailView {
    @ViewBuilder
    var title: some View {
        Text(viewModel.dessertInfo?.strMeal ?? "*****")
            .font(.largeTitle)
        
    }
    
    @ViewBuilder
    var image: some View {
        if let strUrl = viewModel.dessertInfo?.strMealThumb,
           let url = URL(string: strUrl) {
            AsyncImage(url: url) { img in
                img
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
            } placeholder: {
                ProgressView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16,
                                         style: .continuous))
        }
    }
    
    @ViewBuilder
    var ingredientsTitle: some View {
        Text("Ingredients List")
            .font(.title2)
            .bold()
    }
    
    @ViewBuilder
    var instructionsTitle: some View {
        Text("Instructions")
            .font(.title2)
            .bold()
    }
    
    // ALERT UI
    
    @ViewBuilder
    var tryAgainAlertButton: some View {
        Button("Try Again") {
            Task {
                await viewModel.fetchDessertInfo(id:id)
            }
        }
    }
    
    var goBackAlertButton: some View {
        Button("Go Back") {
            presentationMode.wrappedValue.dismiss()
        }
    }
}