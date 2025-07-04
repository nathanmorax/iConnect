//
//  ReusableToolbar.swift
//  iConnect
//
//  Created by Jonathan Mora on 18/06/25.
//
import SwiftUI

struct ToolbarActionModel: Identifiable {

    let id: String
    let title: String
    let systemImageName: String
    let color: Color
    let action: () -> Void
    
    // Factory para crear acciones comunes
    static func delete(action: @escaping () -> Void) -> ToolbarActionModel {
        .init(id: "delete", title: "Delete", systemImageName: "trash", color: .redColor, action: action)
    }
    
    static func cancel(action: @escaping () -> Void) -> ToolbarActionModel {
        .init(id: "cancel", title: "Cancel", systemImageName: "xmark.circle.fill", color: .redColor, action: action)
    }
    
    static func favorite(isFavorite: Bool, action: @escaping () -> Void) -> ToolbarActionModel {
        .init(
            id: "favorite",
            title: "Favorite",
            systemImageName: isFavorite ? "heart.fill" : "heart",
            color: .greenColor,
            action: action
        )
    }
    
    static func save(action: @escaping () -> Void) -> ToolbarActionModel {
        .init(id: "save", title: "Save", systemImageName: "bookmark.fill", color: .yellowColor, action: action)
    }
    
    static func importJSON(action: @escaping () -> Void) -> ToolbarActionModel {
        .init(id: "import", title: "Import JSON", systemImageName: "square.and.arrow.down.fill", color: .greenColor, action: action)
    }
    
    static func exportJSON(action: @escaping () -> Void) -> ToolbarActionModel {
        .init(id: "export", title: "Export JSON", systemImageName: "square.and.arrow.up.fill", color: .lilacColor, action: action)
    }
}

struct ReusableToolbar: View {
    let actions: [ToolbarActionModel]
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(actions) { action in
                Button(action: action.action) {
                    Label(action.title, systemImage: action.systemImageName)
                        .foregroundColor(action.color)
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
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
        .previewLayout(.sizeThatFits)
    }
}
