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

extension ImgurRepositoryError: Equatable {
    static func == (lhs: ImgurRepositoryError, rhs: ImgurRepositoryError) -> Bool {
        switch (lhs, rhs) {
        case (.feedError, .feedError):
            return true
        case (.imageDetailsError, .imageDetailsError):
            return true
        case (.searchError, .searchError):
            return true
        case (.unknown(let lhsError), .unknown(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
