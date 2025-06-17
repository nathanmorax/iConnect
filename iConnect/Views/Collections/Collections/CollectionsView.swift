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
                if modelData.userCollections.isEmpty {
                    Text("You don’t have any saved Collections yet.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                } else {
                    CollectionsGrid()
                        .padding()
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .navigationTitle("Collections")
        .navigationDestination(for: RequestCollection.self) { collection in
            CollectionDetailView(collection: collection)
        }
    }
}






