//
//  MainTabView.swift
//  TechTest
//
//  Created by Kyle Thomas on 31/10/2024.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                FeedView()
            }.tabItem {
                Image(systemName: "house.fill")
                Text("Feed")
            }
        }
    }
}
