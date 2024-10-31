//
//  FavouritesRepository.swift
//  TechTest
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation

class FavouritesRepository: FavouritesRepositoryProtocol {
    
    static let shared: FavouritesRepository = FavouritesRepository()
    
    private let favouritesKey: String = "favourite_images"
    var favouriteIds: [String] = []
    
    init() {
        _ = getFavourites()
    }
    
    func addFavourite(imageModel: ImageModel) -> Result<Bool, FavouritesRepositoryError> {
        var favourites = getFavourites().getOrElse([])
        if favourites.contains(where: { $0.id == imageModel.id }) {
            return .failure(.addFavouriteFailed) // Already exists
        }
        favourites.append(imageModel)
        return storeFavourites(favourites: favourites)
    }
    
    func removeFavourite(imageId: String) -> Result<Bool, FavouritesRepositoryError> {
        var favourites = getFavourites().getOrElse([])
        if let index = favourites.firstIndex(where: { $0.id == imageId }) {
            favourites.remove(at: index)
            return storeFavourites(favourites: favourites)
        } else {
            return .failure(.removeFavouriteFailed)
        }
    }
    
    func getFavourites() -> Result<[ImageModel], FavouritesRepositoryError> {
        guard let data = UserDefaults.standard.data(forKey: favouritesKey) else {
            return .failure(.getFavouritesFailed)
        }
        
        do {
            let favourites = try JSONDecoder().decode([ImageModel].self, from: data)
            self.favouriteIds = favourites.map { $0.id }
            return .success(favourites)
        } catch {
            return .failure(.getFavouritesFailed)
        }
    }
    func storeFavourites(favourites: [ImageModel]) -> Result<Bool, FavouritesRepositoryError> {
        do {
            let data = try JSONEncoder().encode(favourites)
            UserDefaults.standard.set(data, forKey: favouritesKey)
            return .success(true)
        } catch {
            return .failure(.storeFavouritesFailed)
        }
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
