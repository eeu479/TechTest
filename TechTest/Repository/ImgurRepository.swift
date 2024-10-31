//
//  ImgurRepository.swift
//  TechTest
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation

class ImgurRepository: ImgurRepositoryProtocol {
    let api: ImgurApiProtocol
    
    init(api: ImgurApiProtocol) {
        self.api = api
    }
    
    func fetchFeed(page: Int) async throws -> Result<[ImageModel], ImgurRepositoryError> {
        do {
            let result = try await api.getFeed(page: page)
            let images = try result.get()
            return .success(images)
        } catch {
            let repositoryError: ImgurRepositoryError
            if let urlError = error as? URLError, urlError.code == .badServerResponse {
                repositoryError = .feedError
            } else {
                repositoryError = .unknown(error: error)
            }
            return .failure(repositoryError)
        }
    }
    
    func search(query: String, page: Int) async throws -> Result<[ImageModel], ImgurRepositoryError> {
        do {
            let result = try await api.search(query: query, page: page)
            let images = try result.get()
            return .success(images)
        } catch {
            let repositoryError: ImgurRepositoryError
            if let urlError = error as? URLError, urlError.code == .badServerResponse {
                repositoryError = .searchError
            } else {
                repositoryError = .unknown(error: error)
            }
            return .failure(repositoryError)
        }
    }
}
