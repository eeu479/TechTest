//
//  FavouritesDataStoreProtocol.swift
//  TechTest
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation

protocol FavouritesDataStoreProtocol {
    func getFavourites() -> Result<[ImageModel], FavouritesRepositoryError>
    func storeFavourites(favourites: [ImageModel]) -> Result<Bool, FavouritesRepositoryError>
}
