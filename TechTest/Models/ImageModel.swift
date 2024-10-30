//
//  ImageModel.swift
//  TechTest
//
//  Created by Kyle Thomas on 30/10/2024.
//

import Foundation

struct ImageModel: Codable, Identifiable {
    let id: String
    let title: String?
    let link: String?
    let images: [ImageItemModel]?
}
