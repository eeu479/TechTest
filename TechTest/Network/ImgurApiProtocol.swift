//
//  ImgurApiProtocol.swift
//  TechTest
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation

protocol ImgurApiProtocol {
    var baseUrl: URL { get }
    
    func getFeed(page: Int) async throws -> Result<[ImageModel], Error>
}
