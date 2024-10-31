//
//  FeedView.swift
//  TechTest
//
//  Created by Kyle Thomas on 30/10/2024.
//

import Foundation
import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel: FeedViewModel = FeedViewModel(repository: ImgurRepository(api: ImgurApi()))
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 8), count: 2)
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Feed").font(.title)
            TextField("Search...", text: $viewModel.searchQuery)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
            ScrollView {
                if(viewModel.isLoading) {
                    ProgressView()
                } else if(viewModel.images.count > 0) {
                    LazyVGrid(columns: columns, spacing:8) {
                        ForEach(viewModel.images) { image in
                            NavigationLink(destination: ImageDetailsView(model: image)) {
                                ImageCell(model: image).frame(height:150)
                            }
                        }
                    }
                } else {
                    Text("No Images Found")
                }
            }
        }
        .padding()
        .onAppear {
            if viewModel.images.isEmpty {
                viewModel.loadNextPage()
            }
        }
    }
}

#Preview {
        FeedView()
}
