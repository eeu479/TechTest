//
//  ImgurRepositoryError.swift
//  TechTest
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation

enum ImgurRepositoryError: Error {
    case feedError
    case imageDetailsError
    case searchError
    case unknown(error: Error)
}
