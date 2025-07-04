//
//  CollectionSelectionLisItem.swift
//  iConnect
//
//  Created by Jonathan Mora on 13/06/25.
//
import SwiftUI

struct CollectionSelectionLisItem: View {
    let collection: RequestCollection
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "network")
                .resizable()
                .frame(maxWidth: 28, maxHeight: 28)
                .aspectRatio(contentMode: .fill)
            
            Text(collection.name)
            Spacer()
            Image(systemName: isSelected ? "checkmark.square.fill" : "square")

                .symbolRenderingMode(.palette)
                .foregroundStyle(isSelected ? Color.greenColor : Color.grayColor)
                .font(.title)
                .padding(.trailing, Constants.standardPadding)
        }
        .padding()
    }
}

#Preview {
    let modelData = ModelData()
    let previewCollection = modelData.userCollections.first!
    
    CollectionSelectionLisItem(collection: previewCollection, isSelected: true)
}
