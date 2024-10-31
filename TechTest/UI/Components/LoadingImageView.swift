//
//  LoadingImageView.swift
//  TechTest
//
//  Created by Kyle Thomas on 30/10/2024.
//

import Foundation
import SwiftUI

struct LoadingImageView: View {
    let url: URL
    
    var body: some View {
        AsyncImage(url: url) { imagePhase in
            switch imagePhase {
                case .success(let image):
                image.resizable().scaledToFit()
                case .failure:
                    ZStack {
                        Rectangle().fill(.gray)
                        Text("Image Not Found")
                    }
            case .empty:
                ProgressView()
            @unknown default:
                ZStack {
                    Rectangle().fill(.gray)
                    Text("Image Not Found")
                }
            }
        }
    }
}
