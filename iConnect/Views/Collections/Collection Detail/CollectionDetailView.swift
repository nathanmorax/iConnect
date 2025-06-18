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
                    toolBarDeleteAll
                    toolBarFavorite
                }
            }
        }
        .background(Color.background)

    }
    
    var toolBarDeleteAll: some View {
        Button {
            // storage.deleteAllRequests()
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
    
    var toolBarFavorite: some View {
        Button {
            modelData.toggleFavoriteCollection(collection)
        } label: {
            Label(
                "Favorite",
                systemImage: modelData.favoritesCollection.contains(where: { $0.id == collection.id }) ? "heart.fill" : "heart"
            )
        }
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


struct RequestsTabView: View {
    let requests: [Request]
    @Binding var selection: Int

    var body: some View {
        VStack(spacing: 16) {
            // Selector de pestaña (puedes usar Picker, HStack, etc.)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Array(requests.enumerated()), id: \.offset) { index, req in
                        let label = req.endpoint.split(separator: "/").last.map(String.init) ?? req.endpoint

                        Button(action: {
                            selection = index
                        }) {
                            Text(label)
                                .font(.caption)
                                .bold()
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(selection == index ? Color.blueButton : Color.clear)
                                .foregroundColor(selection == index ? .black : .primary)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }

            if requests.indices.contains(selection) {
                RequestView(
                    method: requests[selection].method,
                    endpoint: requests[selection].endpoint,
                    showsToolbar: false
                )
            } else {
                Text("Request no válido")
                    .foregroundStyle(.secondary)
            }
        }
        .background(Color.background)
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
