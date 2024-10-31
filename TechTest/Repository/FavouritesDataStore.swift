//
//  FavouritesDataStore.swift
//  TechTest
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation

class FavouritesDataStore: FavouritesDataStoreProtocol {
    private let favouritesKey: String = "favourite_images"
    
    func getFavourites() -> Result<[ImageModel], FavouritesRepositoryError> {
        guard let data = UserDefaults.standard.data(forKey: favouritesKey) else {
            return .failure(.getFavouritesFailed)
        }
        
        do {
            let favourites = try JSONDecoder().decode([ImageModel].self, from: data)
            return .success(favourites)
        } catch {
            return .failure(.getFavouritesFailed)
        }
    }
    
    internal func storeFavourites(favourites: [ImageModel]) -> Result<Bool, FavouritesRepositoryError> {
        do {
            let data = try JSONEncoder().encode(favourites)
            UserDefaults.standard.set(data, forKey: favouritesKey)
            return .success(true)
        } catch {
            return .failure(.storeFavouritesFailed)
        }
    }
}
