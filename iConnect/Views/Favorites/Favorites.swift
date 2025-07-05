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
                            VStack(alignment: .leading, spacing: 4) {
                                Text(request.title)
                                    .font(.subheadline)
                                Text(request.endpoint)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                
                                // Mostrar headers si existen
                                if let headers = request.headers, !headers.isEmpty {
                                    Text("Headers:")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .padding(.top, 4)
                                    
                                    ForEach(headers.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                                        HStack {
                                            Text(key + ":")
                                                .font(.caption2)
                                                .foregroundColor(.secondary)
                                            Text(value)
                                                .font(.caption2)
                                        }
                                    }
                                }
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



