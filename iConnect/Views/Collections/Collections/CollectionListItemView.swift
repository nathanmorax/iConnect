//
//  CollectionListItemView.swift
//  iConnect
//
//  Created by Jonathan Mora on 13/06/25.
//
import SwiftUI

struct CollectionListItemView: View {
    let collection: RequestCollection
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            Image("icon.collection")
                .resizable()
                .frame(maxWidth: 32, maxHeight: 32)
                .scaledToFill()
            Text(collection.name)
                .infoTitle()
            Text("\(collection.request.count) request")
                .detailedInfoTitle()
            
        }
        .cardStyle()
        .padding()
        
    }
}

#Preview {
    let modelData = ModelData()
    let previewCollection = modelData.userCollections.first!
    
    CollectionListItemView(collection: previewCollection)
}
