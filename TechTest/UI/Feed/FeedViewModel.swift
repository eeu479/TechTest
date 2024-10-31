//
//  FeedViewModel.swift
//  TechTest
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation

@MainActor
class FeedViewModel: ObservableObject {
    @Published var images: [ImageModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var hasMorePages: Bool = true
    
    private let repository: ImgurRepositoryProtocol
    private var currentPage: Int = 0
    
    init(repository: ImgurRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadNextPage() {
        guard hasMorePages, !isLoading else { return }
        
        self.isLoading = true
        self.errorMessage = nil
        self.currentPage += 1
        Task {
            do {
                let result = try await repository.fetchFeed(page: currentPage)
                let newImages = try result.get()
                self.images.append(contentsOf: newImages)
            } catch(let error) {
                if(error is ImgurRepositoryError) {
                    
                }
            }
            isLoading = false
        }
        
    }
}
