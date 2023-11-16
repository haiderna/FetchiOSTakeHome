//
//  DessertListItemViewModel.swift
//  FetchiOSTakeHome
//
//  Created by Najia Haider on 11/15/23.
//

import Foundation
import SwiftUI

class DessertListItemViewModel: ObservableObject {
    let imgCache = Cache()
    let dessert: Dessert
    @Published var uiImage: UIImage?
    
    init(dessert: Dessert) {
        self.dessert = dessert
    }
    
    @MainActor
    func loadImageUsingCache() async {
        
        if let cachedImg = imgCache.getImage(key: dessert.strMealThumb) {
            uiImage = cachedImg
        } else {
            
            do {
                if let url = URL(string: dessert.strMealThumb) {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    if let loadedImg = UIImage(data: data) {
                        uiImage = loadedImg
                        imgCache.setImage(loadedImg, key: dessert.strMealThumb)
                    } else {
                        uiImage = nil
                    }
                }
            } catch {
                uiImage = nil
            }
            
        }
    }
}


class Cache {
    private let cache = NSCache<NSString, UIImage>()
    
    func getImage(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func setImage(_ img: UIImage, key: String) {
        cache.setObject(img, forKey: key as NSString)
    }
}
