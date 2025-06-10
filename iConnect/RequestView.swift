//
//  RequestView.swift
//  iConnect
//
//  Created by Jonathan Mora on 09/06/25.
//
import SwiftUI

struct RequestView: View {
    
    @StateObject private var vm: RequestViewModel
    @EnvironmentObject var storage: RequestStorage
    @State var showSave = false
    
    let method: String
    let endpoint: String
    
    init(method: String = "GET", endpoint: String = "") {
        self.method = method
        self.endpoint = endpoint
        _vm = StateObject(wrappedValue: RequestViewModel(method: method, endpoint: endpoint))
    }
    
    // Agrupar requests por colección con conteo
    var collectionsCount: [(collection: String, count: Int)] {
        let grouped = Dictionary(grouping: storage.savedRequests, by: { $0.collection })
        return grouped.map { ($0.key, $0.value.count) }.sorted(by: { $0.collection < $1.collection })
    }
    
    var body: some View {
        VStack {
            // Lista de colecciones con cantidad de requests guardados
            List(collectionsCount, id: \.collection) { item in
                HStack {
                    Text(item.collection)
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(item.count) request\(item.count == 1 ? "" : "s")")
                        .foregroundColor(.secondary)
                }
            }
            .frame(height: 150) // ajustar tamaño según convenga
            
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
            SaveRequestSheetView(method: vm.selectMethod.rawValue, endpoint: vm.endpoint, storage: _storage)
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
    
    var method: String
    var endpoint: String
    @EnvironmentObject var storage: RequestStorage

    @State private var requestName: String = ""
    @State private var selectedCollection: String = ""
    @State private var showNewCollectionField = false
    @State private var newCollectionName: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Nombre del Request")) {
                TextField("Ej: Obtener usuario", text: $requestName)
            }
            
            Section(header: Text("Colección")) {
                Picker("Colección", selection: $selectedCollection) {
                    ForEach(storage.collections, id: \.self) { collection in
                        Text(collection).tag(collection)
                    }
                    Text("Nueva…").tag("__new")
                }
                .pickerStyle(.menu)
                .onChange(of: selectedCollection) { value in
                    showNewCollectionField = value == "__new"
                }
                
                if showNewCollectionField {
                    TextField("Nombre de la nueva colección", text: $newCollectionName)
                }
            }
            
            Section {
                Button("Guardar") {
                    let collectionToUse = showNewCollectionField ? newCollectionName : selectedCollection
                    storage.saveRequest(name: requestName, method: method, endpoint: endpoint, collection: collectionToUse)
                    dismiss()
                }
                .disabled(requestName.isEmpty || (showNewCollectionField && newCollectionName.isEmpty))
            }
        }
        .onAppear {
            if let first = storage.collections.first {
                selectedCollection = first
            } else {
                selectedCollection = "__new"
                showNewCollectionField = true
            }
        }
    }
}

