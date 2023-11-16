//
//  MealDetailViewModel.swift
//  FetchiOSTakeHome
//
//  Created by Najia Haider on 11/4/23.
//

import Foundation

class MealDetailViewModel: ObservableObject {
    @Published var dessertInfo: DessertDetail?
    @Published var ingredientsList: [String] = [String]()
    @Published var isLoading = false
    @Published var showErrorAlert = false
    @Published var error: NetworkManager.NetworkError?
    
    private var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    @MainActor
    func fetchDessertInfo(id: Int) async {
        isLoading = true
        defer { isLoading = false }
        do {
            let info = try await networkManager.request(.dessertDetail(mealId: id), type: MealDetail.self)
            if let mealInfo = info.meals.first {
                dessertInfo = mealInfo
                ingredientsList = roundUpIngredientsAndMeasurements( optIngredients: mealInfo.strIngredients, optMeasurements: mealInfo.strMeasure)
            } else {
                throw NetworkManager.NetworkError.noMealData
            }
        } catch let error {
            showErrorAlert = true
            if let networkError = error as? NetworkManager.NetworkError {
                self.error = networkError
            } else {
                self.error = .customError(error: error)
            }
        }
    }
    
    func roundUpIngredientsAndMeasurements(optIngredients: [String?], optMeasurements: [String?]) -> [String] {
        
        let ingredients = removeNilsandEmpty(arrayFromAPI: optIngredients)
        let measurements = removeNilsandEmpty(arrayFromAPI: optMeasurements)
        
        let list = zip(ingredients, measurements).map { "\($0): \($1)" }
        return list
    }
    
    func removeNilsandEmpty(arrayFromAPI: [String?]) -> [String] {
        let editedArray = arrayFromAPI.compactMap { item in
            if let nonOptionalItem = item, !nonOptionalItem.isEmpty {
                return nonOptionalItem
            }
            return nil
        }
        return editedArray
    }
    
}
