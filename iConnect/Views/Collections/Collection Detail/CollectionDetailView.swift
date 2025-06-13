//
//  CollectionDetailView.swift
//  iConnect
//
//  Created by Jonathan Mora on 13/06/25.
//
import SwiftUI

struct CollectionDetailView: View {
    @Environment(ModelData.self) var modelData
    @Bindable var collection: RequestCollection
    
    
    var body: some View {
        VStack {
            
            Text(collection.request.map { $0.endpoint }.joined(separator: "\n"))
                .font(.caption)
                .foregroundStyle(.gray)
        }
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
