//
//  RequestView.swift
//  iConnect
//
//  Created by Jonathan Mora on 09/06/25.
//
import SwiftUI

struct RequestView: View {
    
    @StateObject private var vm: RequestViewModel
    //@EnvironmentObject var storage: RequestStorage
    @State var showSave = false
    
    let method: String
    let endpoint: String
    
    init(method: String = "GET", endpoint: String = "") {
        self.method = method
        self.endpoint = endpoint
        _vm = StateObject(wrappedValue: RequestViewModel(method: method, endpoint: endpoint))
    }
    
    // Agrupar requests por colección con conteo
    /*var collectionsCount: [(collection: String, count: Int)] {
        //let grouped = Dictionary(grouping: storage.savedRequests, by: { $0.collection })
        //return grouped.map { ($0.key, $0.value.count) }.sorted(by: { $0.collection < $1.collection })
    }*/
    
    var body: some View {
        VStack {
            // Lista de colecciones con cantidad de requests guardados
            /*List(collectionsCount, id: \.collection) { item in
                HStack {
                    Text(item.collection)
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(item.count) request\(item.count == 1 ? "" : "s")")
                        .foregroundColor(.secondary)
                }
            }
            .frame(height: 150) // ajustar tamaño según convenga*/
            
            Divider()
            
            HStack {
                Text(vm.endpoint)
                
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
        .sheet(isPresented: $showSave) {
            SaveRequestSheetView(method: "", endpoint: "")
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
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
                showSave.toggle()
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
