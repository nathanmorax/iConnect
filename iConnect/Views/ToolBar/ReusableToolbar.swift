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
        case .delete: return "delete"
        case .favorite: return "favorite"
        case .save: return "save"
        case .importJSON: return "import"
        case .exportJSON: return "export"
        }
    }
    
    var title: String {
        switch self {
        case .delete: return "Delete"
        case .favorite: return "Favorite"
        case .save: return "Save"
        case .importJSON: return "Import JSON"
        case .exportJSON: return "Export JSON"
        }
    }
    
    var systemImageName: String {
        switch self {
        case .delete: return "trash"
        case .favorite(let isFavorite, _): return isFavorite ? "heart.fill" : "heart"
        case .save: return "bookmark.fill"
        case .importJSON: return "square.and.arrow.down.fill"
        case .exportJSON: return "square.and.arrow.up.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .delete: return Color.redColor
        case .favorite: return Color.greenColor
        case .save: return Color.yellowColor
        case .importJSON: return Color.greenColor
        case .exportJSON: return Color.lilacColor
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
                    HStack {
                        Image(systemName: action.systemImageName)
                            .foregroundColor(action.color)
                    }
                }
            }
        }
    }
}


struct ReusableToolbar_Previews: PreviewProvider {
    static var previews: some View {
        ReusableToolbar(actions: [
            .delete { print("Delete tapped") },
            .favorite(isFavorite: true) { print("Favorite tapped") },
            .save { print("Save tapped") },
            .importJSON { print("Import tapped") },
            .exportJSON { print("Export tapped") }
        ])
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
