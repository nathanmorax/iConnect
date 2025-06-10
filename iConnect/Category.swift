//
//  Category.swift
//  iConnect
//
//  Created by Jonathan Mora on 07/06/25.
//

import SwiftUI

enum Category: String, CaseIterable, Identifiable {
    case request
    case collections
    case favorites
    case history
    
    var id: Self { self }
    
    var title: String {
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
}


struct CategoryModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let iconName: String
    var category: Category? = nil
    var children: [CategoryModel]? = nil
}

let sidebarCategories: [CategoryModel] = [
    CategoryModel(title: "Requests", iconName: "paperplane.fill", category: .request),
    CategoryModel(title: "Collections", iconName: "cube.fill", category: .collections, children: [
        CategoryModel(title: "Work", iconName: "folder.fill"),
        CategoryModel(title: "Personal", iconName: "folder.fill"),
        CategoryModel(title: "Archived", iconName: "archivebox.fill")
    ]),
    CategoryModel(title: "Favorites", iconName: "heart.fill", category: .favorites),
    CategoryModel(title: "History", iconName: "clock.fill", category: .history, children: [
        CategoryModel(title: "Personal", iconName: "folder.fill"),
        CategoryModel(title: "Archived", iconName: "archivebox.fill")
    ])
]
