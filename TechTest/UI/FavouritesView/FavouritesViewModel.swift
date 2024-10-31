//
//  FavouritesViewModel.swift
//  TechTest
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation

@MainActor
class FavouritesViewModel: ObservableObject {
    @Published var images: [ImageModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    
    private let repository: FavouritesRepositoryProtocol
    
    init(repository: FavouritesRepositoryProtocol) {
        self.repository = repository
    }
    
    func removeFavourite(id: String) {
        let result = repository.removeFavourite(imageId: id)
        images = images.filter{ $0.id != id }
    }
    
    func loadFavourites() {
        guard !isLoading else { return }
        let result = repository.getFavourites()
        do {
            let newImages = try result.get()
            images = newImages.map { image in
                var newImage = image
                newImage.isFavourite = true
                return newImage
            }
        } catch {
            errorMessage = "Failed to load favourites"
        }
    }
}
