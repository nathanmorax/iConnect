//
//  RequestView.swift
//  iConnect
//
//  Created by Jonathan Mora on 09/06/25.
//
import SwiftUI

struct RequestView: View {
    
    @StateObject private var vm: RequestViewModel
    @State var showSave = false
    @State var isShowingLandmarksSelection: Bool = false
    @State private var selectedCollection: RequestCollection? = nil
    @Environment(RequestViewModel.self) var requestViewModel


    let method: String
    let endpoint: String
    
    init(method: String = "GET", endpoint: String = "") {
        self.method = method
        self.endpoint = endpoint
        _vm = StateObject(wrappedValue: RequestViewModel(method: method, endpoint: endpoint))
    }
    
    var body: some View {
        VStack {
            
            Divider()
            
            HStack {
                
                MethodMenuButton(selectedMethod: $vm.selectMethod)
                
                TextField("Endpoint", text: $vm.endpoint)
                
                Button {
                    vm.sendRequest()
                } label: {
                    Text("Send")
                }
                .buttonStyle(.bordered)
                
            }
            .padding()
            
            ResponseViewer(response: $vm.responseText, responseStatusCode: $vm.statusCode, responseTime: $vm.responseTimeMs)
            
            Spacer()
            
        }
        .toolbar {
            ToolbarItemGroup {
                toolBarSaveRequest
            }
        }
        .sheet(isPresented: $isShowingLandmarksSelection) {
            
            CollectionSelectionList(selectedCollection: $selectedCollection, method: vm.selectMethod.rawValue, endpoint: vm.endpoint, requestTitle: vm.responseText)
                .frame(minWidth: 200.0, minHeight: 400.0)
        }
        .onChange(of: method) {
            vm.selectMethod = HTTPMethod(rawValue: method) ?? .get
        }
        .onChange(of: endpoint) {
            vm.endpoint = endpoint
        }

    }
    
    var toolBarSaveRequest: some View {
        VStack {
            Button {
                isShowingLandmarksSelection.toggle()
            } label: {
                Label("Save Request", systemImage: "bookmark.fill")
            }
        }
    }
}



#Preview {
    RequestView(method: "Get", endpoint: "Get")
}

struct SaveRequestSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ModelData.self) var modelData
    
    
    var method: String
    var endpoint: String

    @State private var nameCollection: String = ""
    @State private var selectedCollection: RequestCollection?
    @State private var showNewCollectionField = false
    @State private var newCollectionName: String = ""
    
    var body: some View {
        @Bindable var modelData = modelData

        Form {
            Section(header: Text("Add Request in Collection")) {
                TextField("Name Request", text: $nameCollection)
            }

            Section(header: Text("Colección")) {
                Picker("Colección", selection: $selectedCollection) {
                    ForEach(modelData.userCollections, id: \.self) { collection in
                        Text(collection.name).tag(Optional(collection))
                    }
                    Text("Nueva…").tag(nil as RequestCollection?)
                }
                .pickerStyle(.menu)
                .onChange(of: selectedCollection) { value in
                    showNewCollectionField = (value == nil)
                }

                if showNewCollectionField {
                    TextField("Nombre de la nueva colección", text: $newCollectionName)
                }
            }

            Section {
                Button("Guardar") {
                    let targetCollection: RequestCollection

                    if showNewCollectionField {
                        targetCollection = modelData.addCollection(nameCollection: newCollectionName)
                    } else if let existingCollection = selectedCollection {
                        targetCollection = existingCollection
                    } else {
                        return
                    }

                    _ = modelData.createAndAddRequest(
                        title: nameCollection,
                        method: method,
                        endpoint: endpoint,
                        to: targetCollection
                    )

                    dismiss()
                }
                .disabled(nameCollection.isEmpty || (showNewCollectionField && newCollectionName.isEmpty))
            }
        }
        .onAppear {
            if modelData.userCollections.isEmpty {
                selectedCollection = nil
                showNewCollectionField = true
            } else {
                selectedCollection = modelData.userCollections.first
                showNewCollectionField = false
            }
        }
    }
}
