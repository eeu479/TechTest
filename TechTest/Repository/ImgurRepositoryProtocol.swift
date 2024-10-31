//
//  ImgurRepositoryProtocol.swift
//  TechTest
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation
import Combine

protocol ImgurRepositoryProtocol {
    func fetchFeed(page: Int) async throws -> Result<[ImageModel], ImgurRepositoryError>
    func search(query: String, page: Int) async throws -> Result<[ImageModel], ImgurRepositoryError>
}
