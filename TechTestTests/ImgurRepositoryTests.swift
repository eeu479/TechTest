//
//  ImgurRepositoryTests.swift
//  TechTestTests
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation
import XCTest
@testable import TechTest

class ImgurRepositoryTests: XCTestCase {
    var repository: ImgurRepository!
    var mockApi: ImgurApiMock!
    
    override func setUp() {
        super.setUp()
        mockApi = ImgurApiMock()
        repository = ImgurRepository(api: mockApi)
    }
    
    
    override func tearDown() {
        repository = nil
        mockApi = nil
        super.tearDown()
    }
    
    func testFetchFeedSuccess() async {
        mockApi.shouldReturnError = false
        mockApi.mockImages = [ImageModel.MOCK]
        
        let result = try? await repository.fetchFeed(page: 1)
        
        
        switch result {
        case .success(let images):
            XCTAssertEqual(images.count, 1)
            XCTAssertEqual(images.first?.title, ImageModel.MOCK.title)
        case .failure:
            XCTFail("Expected success but got failure")
        case .none:
            XCTFail("Result was nil")
        }
    }
    
    func testFetchFeedFailure() async {
        
            mockApi.shouldReturnError = true
            
            let result = try? await repository.fetchFeed(page: 1)
        
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error, .feedError)
            case .none:
                XCTFail("Result was nil")
            }
        }
        
        func testSearchSuccess() async {
            // Given
            mockApi.shouldReturnError = false
            mockApi.mockImages = [
                ImageModel.MOCK
            ]
            
            // When
            let result = try? await repository.search(query: "Test", page: 1)
            
            // Then
            switch result {
            case .success(let images):
                XCTAssertEqual(images.count, 1)
                XCTAssertEqual(images.first?.title, ImageModel.MOCK.title)
            case .failure:
                XCTFail("Expected success but got failure")
            case .none:
                XCTFail("Result was nil")
            }
        }
        
        func testSearchFailure() async {
            // Given
            mockApi.shouldReturnError = true
            
            // When
            let result = try? await repository.search(query: "Test", page: 1)
            
            // Then
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error, .searchError)
            case .none:
                XCTFail("Result was nil")
            }
        }
}
