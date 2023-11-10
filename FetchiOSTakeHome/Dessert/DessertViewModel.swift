//
//  DessertViewModel.swift
//  FetchiOSTakeHome
//
//  Created by Najia Haider on 11/4/23.
//

import Foundation

class DessertViewModel: ObservableObject {
    
    @Published var desserts: [Dessert] = [Dessert]()
    @Published var showErrorAlert = false
    @Published var error: NetworkManager.NetworkError?
    
    var isLoading = false
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    @MainActor
    func getDesserts() async {
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            
            let response = try await networkManager.request(.shared, .dessert, type: Meals.self)
            let desserts = response.meals
            self.desserts = desserts.sorted { $0.strMeal < $1.strMeal }
            showErrorAlert = false
        } catch let error {
            
            showErrorAlert = true
            
            if let networkError = error as? NetworkManager.NetworkError {
                self.error = networkError
            } else {
                self.error = .customError(error: error)
            }
            
        }
        
    }
    
}
