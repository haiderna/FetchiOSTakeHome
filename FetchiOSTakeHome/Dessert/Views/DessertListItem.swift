//
//  DessertListItem.swift
//  FetchiOSTakeHome
//
//  Created by Najia Haider on 11/5/23.
//

import SwiftUI

struct DessertListItem: View {
    let dessert: Dessert
    
    var body: some View {
        VStack(spacing: .zero) {
            AsyncImage(url: .init(string: dessert.strMealThumb)) { img in
                img
                    .resizable()
                    .frame(height: 120)
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .center) {
                Text("\(dessert.strMeal)")
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .font(.system(.body, weight: .regular))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity,
                    alignment: .leading)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .circular))
        
    }
}

struct DessertListItem_Previews: PreviewProvider {
    static var previews: some View {
        DessertListItem(dessert: Dessert())
    }
}
