//
//  CollectionSelectionList.swift
//  iConnect
//
//  Created by Jonathan Mora on 13/06/25.
//
import SwiftUI

struct CollectionSelectionList: View {
    @Environment(ModelData.self) var modelData
    @Binding var selectedCollection: RequestCollection?
    @Environment(\.dismiss) var dismiss
    
    
    let method: String
    let endpoint: String
    let requestTitle: String
    
    
    var body: some View {
        VStack {
            List {
                ForEach(modelData.allCollections) { collection in
                    Button {
                        selectedCollection = collection
                    } label: {
                        CollectionSelectionLisItem(
                            collection: collection,
                            isSelected: selectedCollection?.id == collection.id
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        
                        guard let collection = selectedCollection else { return }
                        
                        _ = modelData.createAndAddRequest(
                            title: requestTitle,
                            method: method,
                            endpoint: endpoint,
                            to: collection
                        )
                        
                        dismiss()
                        
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                
            }
            .navigationTitle("Select Collection")
        }
        .padding()
    }
}

#Preview {
    CollectionSelectionList(
        selectedCollection: .constant(nil),
        method: "GET",
        endpoint: "/api/example",
        requestTitle: "Test Request"
    )
    .environment(ModelData())
}




