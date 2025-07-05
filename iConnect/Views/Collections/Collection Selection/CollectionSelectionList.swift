//
//  CollectionSelectionList.swift
//  iConnect
//
//  Created by Jonathan Mora on 13/06/25.
//
import SwiftUI

struct CollectionSelectionList: View {
    @Environment(ModelData.self) var modelData
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedCollection: RequestCollection?
    @Binding var collectionName: String
    
    let method: String
    let endpoint: String
    let requestTitle: String
    
    var headers: [PathHeaderRequestModel]
    
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
                    .cardStyle(cornerRadius: 8)
                    .buttonStyle(.plain)
                    .listRowSeparator(.hidden)
                }
            }
            
            TextField("New collection name", text: $collectionName)
                .textFieldStyle()
                .cardStyle(cornerRadius: 8)
                .padding()
            
                .toolbar {
                    ToolbarItemGroup {
                        ReusableToolbar(actions: [
                            ToolbarActionModel.save {
                                self.saveRequestInCollection()
                            },
                            ToolbarActionModel.cancel {
                                dismiss()
                            }
                        ])
                    }
                }
            
                .navigationTitle("Select Collection")
        }
        .padding()
    }
    
    func saveRequestInCollection() {
        
        let filteredHeaders = headers
            .map { PathHeaderRequestModel(name: $0.name.trimmingCharacters(in: .whitespaces),
                                          value: $0.value.trimmingCharacters(in: .whitespaces)) }
            .filter { !$0.name.isEmpty && !$0.value.isEmpty }
        
        print("Header::: ", filteredHeaders)
        print("method::: ", method)
        print("endpoint::: ", endpoint)

        
        let trimmedName = collectionName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty || selectedCollection != nil else {
            return
        }
        
        let targetCollection: RequestCollection
        
        if let selected = selectedCollection {
            targetCollection = selected
        } else {
            targetCollection = modelData.addCollection(nameCollection: trimmedName)
            selectedCollection = targetCollection
        }
        
        let saveRequest = modelData.createAndAddRequest(
            title: requestTitle,
            method: method,
            endpoint: endpoint, headers: filteredHeaders,
            to: targetCollection
        )
        print("📦 Request guardado:")
        dump(saveRequest)
        dismiss()
        
    }
}

/*#Preview {
 CollectionSelectionList(
 selectedCollection: .constant(nil),
 collectionName: .constant(""), method: "GET",
 endpoint: "/api/example",
 requestTitle: "Test Request", headers: [PathHeaderRequestModel(name: "", value: "")]
 )
 .environment(ModelData())
 }
 */



