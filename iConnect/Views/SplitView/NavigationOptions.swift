//
//  Category.swift
//  iConnect
//
//  Created by Jonathan Mora on 07/06/25.
//

import SwiftUI

enum NavigationOptions: Equatable, Hashable, Identifiable {
    case request
    case collections
    case favorites
    case history
    
    static let mainPages: [NavigationOptions] = [.request, .collections, .favorites, .history]

    var id: String {
        switch self {
        case .request: "Requests"
        case .collections: "Collections"
        case .favorites: "Favorites"
        case .history: "History"
        }
    }
    
    var name: String {
        switch self {
        case .request: "Requests"
        case .collections: "Collections"
        case .favorites: "Favorites"
        case .history: "History"
        }
    }
    
    var iconName: String {
        switch self {
        case .request: "paperplane.fill"
        case .collections: "cube.fill"
        case .favorites: "heart.fill"
        case .history: "clock.fill"
        }
    }
    
    @MainActor
    @ViewBuilder
    func viewForPage() -> some View {
        switch self {
        case .request:
            RequestView()
                .navigationTitle("Request")
        case .collections:
            CollectionsView()
                .navigationTitle("Collections")
        case .favorites:
            FavoritesView()
                .navigationTitle("Favorites")
        case .history:
            HistoryView()
                .navigationTitle("History")
        }
    }
}


struct HistoryView: View {
    var body: some View {
        Text("HistoryView")
    }
}


