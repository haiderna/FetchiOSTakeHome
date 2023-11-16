//
//  MealDetailModel.swift
//  FetchiOSTakeHome
//
//  Created by Najia Haider on 11/4/23.
//

import Foundation

struct MealDetail: Codable {
    let meals: [DessertDetail]
    
    init() {
        self.meals = [DessertDetail()]
    }
}

struct DessertDetail: Codable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strTags: String?
    let strIngredients: [String?]
    let strMeasure: [String?]
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?

    enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strDrinkAlternate
        case strCategory
        case strArea
        case strInstructions
        case strMealThumb
        case strTags
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
        case strSource
        case strImageSource
        case strCreativeCommonsConfirmed
        case dateModified

    }
    
    init(from decoder: Decoder) throws {
        let cntr = try decoder.container(keyedBy: CodingKeys.self)
        
        // Single Keys nonNil
        idMeal = try cntr.decode(String.self, forKey: .idMeal)
        strMeal = try cntr.decode(String.self, forKey: .strMeal)
        strCategory = try cntr.decode(String.self, forKey: .strCategory)
        strArea = try cntr.decode(String.self, forKey: .strArea)
        strInstructions = try cntr.decode(String.self, forKey: .strInstructions)
        strMealThumb = try cntr.decode(String.self, forKey: .strMealThumb)
        
        // Possible Nil values
        strDrinkAlternate = try cntr.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
        strSource = try cntr.decodeIfPresent(String.self, forKey: .strSource)
        strImageSource = try cntr.decodeIfPresent(String.self, forKey: .strImageSource)
        strCreativeCommonsConfirmed = try cntr.decodeIfPresent(String.self, forKey: .strCreativeCommonsConfirmed)
        dateModified = try cntr.decodeIfPresent(String.self, forKey: .dateModified)
        strTags = try cntr.decodeIfPresent(String.self, forKey: .strTags)
        
        // Multi Values -> store as optionals and then filter once you get to main screen
        var ingredientsArray = [String?]()
        for i in 1 ... 20 {
            if let key = CodingKeys(rawValue: "strIngredient\(i)") {
                let value = try? cntr.decodeIfPresent(String.self, forKey: key)
                    ingredientsArray.append(value)
            }
        }
        strIngredients = ingredientsArray

        var measureArray = [String?]()
        for i in 1 ... 20 {
            if let key = CodingKeys(rawValue: "strMeasure\(i)") {
                let value = try? cntr.decodeIfPresent(String.self, forKey: key)
                measureArray.append(value)
            }
        }
        strMeasure = measureArray
        
    }
    
    // if in future user wants to add functionality to add dessert recipes
    func encode(to encoder: Encoder) throws {
        var cntr = try encoder.container(keyedBy: CodingKeys.self)
        
        // the array values
        for (i, v) in strIngredients.enumerated() {
            if let key = CodingKeys(rawValue: "strIngredient\(i + 1)") {
                try cntr.encode(v, forKey: key)
            }
        }
        
        for (i, v) in strMeasure.enumerated() {
            if let key = CodingKeys(rawValue: "strMeasure\(i + 1)") {
                try cntr.encode(v, forKey: key)
            }
        }
    }
    
    // Convenience Init
    init() {
        self.idMeal = "1"
        self.strMeal = "Ice Cream"
        self.strIngredients = ["Open box", "Put in bowl"]
        self.strMeasure = ["1 box, 1 bowl"]
        self.strCategory = "Cold"
        self.strArea = "America"
        self.strMealThumb = "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg"
        self.strDrinkAlternate = nil
        self.strSource = nil
        self.strTags = "#Cold"
        self.dateModified = nil
        self.strImageSource = nil
        self.strCreativeCommonsConfirmed = nil
        self.strInstructions = "Heat oven to 190C/170C fan/gas 5. Tip the flour and sugar into a large bowl. Add the butter, then rub into the flour using your fingertips to make a light breadcrumb texture. Do not overwork it or the crumble will become heavy. Sprinkle the mixture evenly over a baking sheet and bake for 15 mins or until lightly coloured. \n Meanwhile, for the compote, peel, core and cut the apples into 2cm dice. Put the butter and sugar in a medium saucepan and melt together over a medium heat. Cook for 3 mins until the mixture turns to a light caramel. Stir in the apples and cook for 3 mins. Add the blackberries and cinnamon, and cook for 3 mins more. Cover, remove from the heat, then leave for 2-3 mins to continue cooking in the warmth of the pan. \n To serve, spoon the warm fruit into an ovenproof gratin dish, top with the crumble mix, then reheat in the oven for 5-10 mins. Serve with vanilla ice cream."
    }


}
