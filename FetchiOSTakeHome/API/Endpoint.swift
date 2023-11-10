//
//  Endpoint.swift
//  FetchiOSTakeHome
//
//  Created by Najia Haider on 11/5/23.
//

import Foundation

enum Endpoint {
    case dessert
    case dessertDetail(mealId: Int)
    case fake
}

extension Endpoint {
    var url: URL? {
        switch self {
        case .dessert:
            let str = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
            return URL(string: str)
        case .dessertDetail(mealId: let mealId):
            let str = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)"
            return URL(string: str)
        case .fake:
            let str = "asdfasdf"
            return URL(string: str)
        }
    }
}
