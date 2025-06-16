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

    var body: some View {
        VStack {
            Text(collection.name)
                .font(.title2)
                .padding()

            if collection.request.isEmpty {
                Text("No hay requests en esta colección")
                    .foregroundStyle(.secondary)
            } else {
                TabView(selection: $selection) {
                    ForEach(Array(collection.request.enumerated()), id: \.offset) { index, req in
                        RequestView(method: req.method, endpoint: req.endpoint, showsToolbar: false)
                            .tag(index)
                            .padding()
                            .tabItem {
                                Text(req.endpoint.split(separator: "/").last.map(String.init) ?? req.endpoint)
                            }
                    }
                }
                .frame(minWidth: 400, minHeight: 300)
                .tabViewStyle(.grouped)
            }
        }
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
