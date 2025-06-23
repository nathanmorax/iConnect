//
//  CollectionDetailView.swift
//  iConnect
//
//  Created by Jonathan Mora on 13/06/25.
//
import SwiftUI

struct CollectionDetailView: View {
    let collection: RequestCollection
    @State private var selection = 0
    @Environment(ModelData.self) var modelData
    
    var body: some View {
        ZStack {
            VStack {
                CollectionHeader(title: collection.name)
                
                
                RequestsTabView(requests: collection.request, selection: $selection)
                
            }
            .padding()
            .toolbar {
                ToolbarItemGroup {
                    ReusableToolbar(actions: [
                        .delete { /* borrar */ },
                        .favorite(
                            isFavorite: modelData.favoritesCollection.contains(where: { $0.id == collection.id })
                        ) {
                            modelData.toggleFavoriteCollection(collection)
                        },
                        .exportJSON({})
                    ])
                }
            }
            
        }
        .background(Color.background)
        
    }
}


struct EmptyStateView: View {
    var body: some View {
        Text("No hay requests en esta colección")
            .foregroundStyle(.secondary)
    }
}

struct CollectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .padding()
    }
}


#Preview {
    let modelData = ModelData()
    let previewCollection = modelData.userCollections.last!
    
    NavigationStack {
        CollectionDetailView(collection: previewCollection)
            .environment(modelData)
    }
}
