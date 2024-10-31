//
//  FavouritesRepositoryError.swift
//  TechTest
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation

enum FavouritesRepositoryError: Error {
    case getFavouritesFailed
    case storeFavouritesFailed
    case addFavouriteFailed
    case removeFavouriteFailed
}
