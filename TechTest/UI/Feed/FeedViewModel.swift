//
//  FeedViewModel.swift
//  TechTest
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation
import Combine

@MainActor
class FeedViewModel: ObservableObject {
    @Published var images: [ImageModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var hasMorePages: Bool = true
    @Published var searchQuery: String = ""
    @Published var searchResults: [ImageModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    
    private let repository: ImgurRepositoryProtocol
    private let favouritesRepository: FavouritesRepositoryProtocol
    private var currentPage: Int = 0
    
    init(repository: ImgurRepositoryProtocol, favouritesRepository: FavouritesRepositoryProtocol) {
        self.repository = repository
        self.favouritesRepository = favouritesRepository
        self.setupSearchSubscription()
    }
    
    func favouriteButtonPressed(image: ImageModel) {
        if image.isFavourite == true {
            _ = favouritesRepository.removeFavourite(imageId: image.id)
            if let index = images.firstIndex(where: { $0.id == image.id }) {
                images[index].isFavourite = false
            }
        } else {
            _ = favouritesRepository.addFavourite(imageModel: image)
            if let index = images.firstIndex(where: { $0.id == image.id }) {
                images[index].isFavourite = true
            }
        }
    }
    
    func loadNextPage() {
        guard hasMorePages, !isLoading else { return }
        
        self.isLoading = true
        self.errorMessage = nil
        self.currentPage += 1
        Task {
            do {
                let result = try await repository.fetchFeed(page: currentPage)
                let newImages = try result.get().map { image in
                    var newImage = image
                    newImage.isFavourite = favouritesRepository.favouriteIds.contains(newImage.id)
                    return newImage
                }
                self.images.append(contentsOf: newImages)
            } catch(let error) {
                if(error is ImgurRepositoryError) {
                    errorMessage = "Failed to fetch images"
                }
            }
            isLoading = false
        }
    }
    
    private func search(query: String) {
        guard !query.isEmpty else {
            self.images = []
            self.currentPage = 0
            self.hasMorePages = true
            loadNextPage()
            return
        }
        
        isLoading = true
        Task {
            do {
                let result = try await repository.search(query: query, page: 1)
                switch result {
                case .success(let images):
                    self.images = images
                    self.hasMorePages = false
                case .failure:
                    self.errorMessage = "Failed to load search results. Please try again later."
                }
            } catch {
                self.errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    private func setupSearchSubscription() {
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else { return }
                if(query != "") {
                    self.search(query: query)
                } else {
                    self.currentPage = 0
                    self.images = []
                    self.hasMorePages = true
                    self.loadNextPage()
                }
            }
            .store(in: &cancellables)
    }
}
