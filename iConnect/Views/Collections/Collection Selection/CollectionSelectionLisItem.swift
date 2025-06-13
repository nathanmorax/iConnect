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
        HStack(spacing: 8) {
            Image(systemName: "cube")
                .resizable()
                .frame(maxWidth: 32, maxHeight: 32)
                .aspectRatio(contentMode: .fill)
            
            Text(collection.name)
            Spacer()
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .symbolRenderingMode(.palette)
                .foregroundStyle(isSelected ? .teal : .gray)
                .font(.title)
                .padding(.trailing, Constants.standardPadding)
        }
        .padding()
    }
}

