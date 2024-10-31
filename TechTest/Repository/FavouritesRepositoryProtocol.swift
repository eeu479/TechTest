//
//  FavouritesRepositoryProtocol.swift
//  TechTest
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation

protocol FavouritesRepositoryProtocol {
    var favouriteIds: [String] { get }
    
    func addFavourite(imageModel: ImageModel) -> Result<Bool, FavouritesRepositoryError>
    func removeFavourite(imageId: String) -> Result<Bool, FavouritesRepositoryError>
    func getFavourites() -> Result<[ImageModel], FavouritesRepositoryError>
    func storeFavourites(favourites: [ImageModel]) -> Result<Bool, FavouritesRepositoryError>
}
