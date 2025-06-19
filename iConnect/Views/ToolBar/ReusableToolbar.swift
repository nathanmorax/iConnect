//
//  ReusableToolbar.swift
//  iConnect
//
//  Created by Jonathan Mora on 18/06/25.
//
import SwiftUI

enum ToolbarAction {
    case delete(() -> Void)
    case favorite(isFavorite: Bool, () -> Void)
    case save(() -> Void)
}

struct ReusableToolbar: View {
    let actions: [ToolbarAction]

    var body: some View {
        HStack {
            ForEach(Array(actions.enumerated()), id: \.offset) { _, action in
                switch action {
                case .delete(let action):
                    Button(action: action) { Label("Delete", systemImage: "trash") }
                case .favorite(let isFav, let action):
                    Button(action: action) {
                        Label("Favorite", systemImage: isFav ? "heart.fill" : "heart")
                    }
                case .save(let action):
                    Button(action: action) { Label("Save", systemImage: "bookmark.fill") }
                }
            }
        }
    }
}

