//
//  FavouritesRepositoryTests.swift
//  TechTestTests
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation
import XCTest
@testable import TechTest

class FavouritesRepositoryTests: XCTestCase {
    var mockDataStore: FavouritesDataStoreMock!
    var repository: FavouritesRepositoryProtocol!
    
    override func setUp() {
        super.setUp()
        mockDataStore = FavouritesDataStoreMock()
        repository = FavouritesRepository(dataStore: mockDataStore)
    }
    
    override func tearDown() {
        mockDataStore = nil
        repository = nil
        super.tearDown()
    }
    
    func testGetFavouritesSuccess() {
        mockDataStore.favourites = [ImageModel.MOCK]
        
        let result = repository.getFavourites()
        
        switch result {
        case .success(let images):
            XCTAssertEqual(images.count, 1)
            XCTAssertEqual(images.first?.title, ImageModel.MOCK.title)
        case .failure:
            XCTFail("Expected success but got failure")
        }
    }
    
    func testGetFavouritesError() {
        mockDataStore.shouldReturnError = true
        let result = repository.getFavourites()
        
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error, .getFavouritesFailed)
        }
    }
    
    func testAddFavouriteSuccess() {
        mockDataStore.favourites = []
        
        let result = repository.addFavourite(imageModel: ImageModel.MOCK)
        switch result {
        case .success(let s):
            XCTAssertTrue(s)
        case .failure:
            XCTFail("Expected success but got failure")
        }
        
        let favourites = repository.getFavourites()
        switch favourites {
        case .success(let images):
            XCTAssertEqual(images.count, 1)
            XCTAssertEqual(images.first?.title, ImageModel.MOCK.title)
        case .failure:
            XCTFail("Expected success but got failure")
        }
    }
    
    func testRemoveFavouriteSuccess() {
        mockDataStore.favourites = [ImageModel.MOCK]
        
        let result = repository.removeFavourite(imageId: ImageModel.MOCK.id)
        switch result {
        case .success(let s):
            XCTAssertTrue(s)
        case .failure:
            XCTFail("Expected success but got failure")
        }
        
        let favourites = repository.getFavourites()
        switch favourites {
        case .success(let images):
            XCTAssertEqual(images.count, 0)
        case .failure:
            XCTFail("Expected success but got failure")
        }
    }
}
