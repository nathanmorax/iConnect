//
//  CollectionsView.swift
//  iConnect
//
//  Created by Jonathan Mora on 13/06/25.
//

import SwiftUI

struct CollectionsView: View {
    @Environment(ModelData.self) var modelData
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                CollectionsGrid()
                    .padding()
                    .cornerRadius(8)
            }
            .padding()
        }
        .navigationTitle("Collections")
        .toolbar {
            ToolbarItemGroup {
                toolBarDeleteAll
            }
        }
        .navigationDestination(for: RequestCollection.self) { collection in
            CollectionDetailView(collection: collection)
        }
    }
    
    var toolBarDeleteAll: some View {
        Button {
            // storage.deleteAllRequests()
        } label: {
            Label("Eliminar Todos", systemImage: "trash")
        }
    }
}






