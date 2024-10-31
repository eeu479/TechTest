//
//  ImageCell.swift
//  TechTest
//
//  Created by Kyle Thomas on 30/10/2024.
//

import Foundation
import SwiftUI

struct ImageCell: View {
    
    let model: ImageModel
    var onFavourite: () -> Void
    
    private var imageUrl: URL? {
        
        if let firstImageLink = model.images?.first?.link {
            return URL(string: firstImageLink)
        }
        print(model.id)
        return nil
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let url = imageUrl {
                LoadingImageView(url: url)
                Button(action: onFavourite) {
                    Image(systemName: (model.isFavourite ?? false) ? "star.fill" : "star")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.yellow)
                }
                .padding(4)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 4)
                .padding()
            } else {
                ZStack {
                    Rectangle().fill(.gray)
                    Text("Image Not Founds")
                }
            }
        }
    }
}

#Preview {
    ImageCell(model: ImageModel.MOCK, onFavourite: {})
}
