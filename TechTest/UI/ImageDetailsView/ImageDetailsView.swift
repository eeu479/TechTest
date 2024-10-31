//
//  ImageDetailsView.swift
//  TechTest
//
//  Created by Kyle Thomas on 30/10/2024.
//

import Foundation
import SwiftUI

struct ImageDetailsView: View {
    let model: ImageModel
    private var imageUrl: URL? {
        if let firstImageLink = model.images?.first?.link {
            return URL(string: firstImageLink)
        }
        return nil
    }
    
    var body: some View {
            VStack(alignment: .leading) {
                if let url = imageUrl {
                    LoadingImageView(url: url)
                } else {
                    Text("Image Not Found")
                }
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: "eye.fill")
                                .frame(height: 16)
                            Text("\(model.views ?? 0)")
                        }
                        VStack {
                            Image(systemName: "hand.thumbsup.fill")
                                .frame(height: 16)
                            Text("\(model.ups ?? 0)")
                        }
                        VStack {
                            Image(systemName: "hand.thumbsdown.fill")
                                .frame(height: 16)
                            Text("\(model.downs ?? 0)")
                        }
                        Spacer()
                    }
                    VStack(alignment: .leading) {
                        Text("Title:")
                            .font(.headline)
                        Text(model.title ?? "No Title Available")
                            .font(.body)
                            .foregroundColor(.primary)
                        
                        Text("Description:")
                            .font(.headline)
                        Text(model.description ?? "No Description Available")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
            }.padding()
            .background(Color.white)
            .navigationTitle("Image Details View")
    }
}

#Preview {
    ImageDetailsView(model: ImageModel.MOCK)
}
