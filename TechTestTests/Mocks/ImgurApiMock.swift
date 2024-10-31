//
//  ImgurApiMock.swift
//  TechTestTests
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation
@testable import TechTest

class ImgurApiMock: ImgurApiProtocol {
    var baseUrl: URL = URL(string: "adasdasdsa")!
    var shouldReturnError = false
    var mockImages: [ImageModel] = []
    
    func getFeed(page: Int) async throws -> Result<[ImageModel], Error> {
        if shouldReturnError {
            return .failure(URLError(.badServerResponse))
        } else {
            return .success(mockImages)
        }
    }
    
    func search(query: String, page: Int) async throws -> Result<[ImageModel], Error> {
        if shouldReturnError {
            return .failure(URLError(.badServerResponse))
        } else {
            return .success(mockImages.filter { $0.title?.localizedCaseInsensitiveContains(query) == true })
        }
    }
}
