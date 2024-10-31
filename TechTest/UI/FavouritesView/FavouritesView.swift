//
//  FavouritesView.swift
//  TechTest
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation
import SwiftUI

struct FavouritesView: View {
    
    @StateObject private var viewModel: FavouritesViewModel = FavouritesViewModel(repository: FavouritesRepository.shared)
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 8), count: 2)
    
    var body: some View {
        VStack {
            Text("Favourites")
                .padding(32)
            ScrollView {
                if(viewModel.isLoading) {
                    ProgressView()
                } else if(viewModel.images.count > 0) {
                    LazyVGrid(columns: columns, spacing:8) {
                        ForEach(viewModel.images) { image in
                            NavigationLink(destination: ImageDetailsView(model: image)) {
                                ImageCell(model: image, onFavourite: {
                                    viewModel.removeFavourite(id: image.id)
                                })
                                    .frame(height:150)
                            }
                        }
                    }
                } else {
                    Text("You currently have no favourites")
                }
            }

        }
        .onAppear {
            viewModel.loadFavourites()
        }
    }
}

#Preview {
    FavouritesView()
}
