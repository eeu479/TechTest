//
//  FavouritesDataStoreMock.swift
//  TechTestTests
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation
@testable import TechTest

class FavouritesDataStoreMock: FavouritesDataStoreProtocol {
    var favourites: [ImageModel] = []
    var shouldReturnError = false
    
    func getFavourites() -> Result<[TechTest.ImageModel], TechTest.FavouritesRepositoryError> {
        if shouldReturnError {
            return Result.failure(.getFavouritesFailed)
        } else {
            return Result.success(favourites)
        }
    }
    
    func storeFavourites(favourites: [TechTest.ImageModel]) -> Result<Bool, TechTest.FavouritesRepositoryError> {
        if shouldReturnError {
            return Result.failure(.storeFavouritesFailed)
        } else {
            self.favourites = favourites
            return Result.success(true)
        }
    }
}
