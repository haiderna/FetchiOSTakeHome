//
//  DessertModel.swift
//  FetchiOSTakeHome
//
//  Created by Najia Haider on 11/4/23.
//

import Foundation

struct Meals: Codable {
    let meals: [Dessert]
}

struct Dessert: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        
        if let mealIdString = try? container.decode(String.self, forKey: .idMeal), let mealIdInt = Int(mealIdString) {
            idMeal = mealIdInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .idMeal, in: container, debugDescription: "Decoding from String to Int for idMeal failed")
        }
    }
    
    // Convenience Init
    init() {
        self.strMeal = "Ice Cream"
        self.strMealThumb = "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"
        self.idMeal = 1
    }
}
