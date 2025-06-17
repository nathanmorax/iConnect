//
//  FavoritesView.swift
//  iConnect
//
//  Created by Jonathan Mora on 14/06/25.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(ModelData.self) var modelData

    var body: some View {
        List {
            if modelData.favoritesCollection.isEmpty {
                Text("No favorite collections yet.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(modelData.favoritesCollection, id: \.id) { collection in
                    Section(header: Text(collection.name)) {
                        ForEach(collection.request, id: \.id) { request in
                            VStack(alignment: .leading) {
                                Text(request.title)
                                    .font(.subheadline)
                                Text(request.endpoint)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
        }
        .navigationTitle("Favorites")
    }
}



