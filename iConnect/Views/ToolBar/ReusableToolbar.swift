//
//  ReusableToolbar.swift
//  iConnect
//
//  Created by Jonathan Mora on 18/06/25.
//
import SwiftUI

enum ToolbarAction: Identifiable {
    case delete(() -> Void)
    case favorite(isFavorite: Bool, () -> Void)
    case save(() -> Void)
    case importJSON (() -> Void)
    case exportJSON (() -> Void)

    var id: String {
        switch self {
        case .delete: "delete"
        case .favorite: "favorite"
        case .save: "save"
        case .importJSON: "import"
        case .exportJSON: "export"
        }
    }

    var label: Label<Text, Image> {
        switch self {
        case .delete:
            Label("Delete", systemImage: "trash")
        case .favorite(let isFavorite, _):
            Label("Favorite", systemImage: isFavorite ? "heart.fill" : "heart")
        case .save:
            Label("Save", systemImage: "bookmark.fill")
        case .importJSON:
            Label("Import JSON", systemImage: "square.and.arrow.down.fill")
        case .exportJSON:
            Label("Export JSON", systemImage: "square.and.arrow.up.fill")
        }
    }

    var action: () -> Void {
        switch self {
        case .delete(let action),
             .favorite(_, let action),
             .save(let action),
             .importJSON(let action),
             .exportJSON(let action):
            return action
        }
    }
}

struct ReusableToolbar: View {
    let actions: [ToolbarAction]

    var body: some View {
        HStack {
            ForEach(actions) { action in
                Button(action: action.action) {
                    action.label
                }
            }
        }
    }
}


