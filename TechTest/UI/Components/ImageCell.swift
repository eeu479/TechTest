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
    ImageCell(model: ImageModel.MOCK)
}
