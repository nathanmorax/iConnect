//
//  CollectionsGrid.swift
//  iConnect
//
//  Created by Jonathan Mora on 13/06/25.
//
import SwiftUI

struct CollectionsGrid: View {
    @Environment(ModelData.self) var modelData

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .leading, spacing: Constants.collectionGridSpacing) {
                ForEach(modelData.userCollections, id: \.id) { collection in
                    NavigationLink(value: collection) {
                        CollectionListItemView(collection: collection)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.all, 8)
    }
    
    private var columns: [GridItem] {
        [ GridItem(.adaptive(minimum: Constants.collectionGridItemMinSize,
                             maximum: Constants.collectionGridItemMaxSize),
                   spacing: Constants.collectionGridSpacing) ]
    }
}

#Preview {
    let modelData = ModelData()

    CollectionsGrid()
        .environment(modelData)
}
