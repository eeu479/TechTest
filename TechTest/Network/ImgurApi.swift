//
//  ImgurApi.swift
//  TechTest
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation

class ImgurApi: ImgurApiProtocol {
    let baseUrl: URL = URL(string: "https://api.imgur.com/3/")!
    let clientId: String = "7988d1736717e56"
    
    func getFeed(page: Int) async throws -> Result<[ImageModel], Error> {
        let feedUrl = baseUrl
            .appendingPathComponent("gallery/hot/")
            .appendingPathComponent("\(page)")
        
        var request = URLRequest(url: feedUrl)
        request.setValue("Client-ID \(clientId)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return .failure(URLError(.badServerResponse))
            }
            
            print(httpResponse)
            let decodedResponse = try JSONDecoder().decode(ImgurResponse.self, from: data)
            return .success(decodedResponse.data.filter { $0.images != nil && $0.images?.first?.type.contains("video") == false })
        } catch(let error) {
            print(error)
            return .failure(error)
        }
    }
    
    
}
