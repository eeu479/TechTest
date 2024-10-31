//
//  FavouritesRepository.swift
//  TechTest
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation

class FavouritesRepository: FavouritesRepositoryProtocol {
    
    static let shared: FavouritesRepository = FavouritesRepository(dataStore: FavouritesDataStore())
    let dataStore: FavouritesDataStoreProtocol
    
    var favouriteIds: [String] = []
    
    init(dataStore: FavouritesDataStoreProtocol) {
        self.dataStore = dataStore
        _ = self.getFavourites()
    }
    
    func addFavourite(imageModel: ImageModel) -> Result<Bool, FavouritesRepositoryError> {
        var favourites = self.getFavourites().getOrElse([])
        if favourites.contains(where: { $0.id == imageModel.id }) {
            return .failure(.addFavouriteFailed) // Already exists
        }
        favourites.append(imageModel)
        return self.dataStore.storeFavourites(favourites: favourites)
    }
    
    func removeFavourite(imageId: String) -> Result<Bool, FavouritesRepositoryError> {
        var favourites = self.getFavourites().getOrElse([])
        if let index = favourites.firstIndex(where: { $0.id == imageId }) {
            favourites.remove(at: index)
            return self.dataStore.storeFavourites(favourites: favourites)
        } else {
            return .failure(.removeFavouriteFailed)
        }
    }
    
    func getFavourites() -> Result<[ImageModel], FavouritesRepositoryError> {
        let favourites = self.dataStore.getFavourites()
        self.favouriteIds = favourites.getOrElse([]).map { $0.id }
        return favourites
    }
}


extension Result where Failure == FavouritesRepositoryError {
    func getOrElse(_ fallback: Success) -> Success {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return fallback
        }
    }
}
