//
//  DessertListItem.swift
//  FetchiOSTakeHome
//
//  Created by Najia Haider on 11/5/23.
//

import SwiftUI

struct DessertListItem: View {
    @StateObject var viewModel: DessertListItemViewModel
    
    var body: some View {
        VStack(spacing: .zero) {
            if let img = viewModel.uiImage {
                Image(uiImage: img)
                    .resizable()
                    .frame(height: 120)
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            } else {
                ProgressView()
                    .task {
                    await viewModel.loadImageUsingCache()
                }
            }
            VStack(alignment: .center) {
                Text("\(viewModel.dessert.strMeal)")
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
        DessertListItem(viewModel: DessertListItemViewModel(dessert: Dessert()))
    }
}
