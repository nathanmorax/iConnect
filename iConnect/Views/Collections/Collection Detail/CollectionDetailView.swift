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
                
                RequestView()
                    .cardStyle()

                
                //RequestsTabView(requests: collection.request, selection: $selection)
                
            }
            .padding()
            .toolbar {
                ToolbarItemGroup {
                    toolBarDeleteAll
                    toolBarFavorite
                }
            }
        }
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
        TabView(selection: $selection) {
            ForEach(Array(requests.enumerated()), id: \.offset) { index, req in
                RequestView(method: req.method, endpoint: req.endpoint, showsToolbar: false)
                    .tag(index)
                    .padding()
                    .background(Color.backgroundSecondary)
                    .tabItem {
                        Text(req.endpoint.split(separator: "/").last.map(String.init) ?? req.endpoint)
                    }
            }
        }
        .frame(minWidth: 400, minHeight: 300)
        .background(Color.backgroundSecondary)
        .tabViewStyle(.grouped)
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
