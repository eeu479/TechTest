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
    let description: String?
    let views: Int?
    let ups: Int?
    let downs: Int?
    var isFavourite: Bool?
}


extension ImageModel {
    static var MOCK: ImageModel {
        ImageModel(
            id: "Test",
            title: "test",
            link: "test",
            images: [
                ImageItemModel(
                    id: "Test",
                    link: "https://picsum.photos/200/300",
                    type: "image/png")
                ],
            description: "Test Image Description",
            views: 100,
            ups: 100,
            downs: 100,
            isFavourite: true
        )
    }
}
