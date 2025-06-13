//
//  ContentView.swift
//  iConnect
//
//  Created by Jonathan Mora on 07/06/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(ModelData.self) var modelData
    @State private var preferredColumn: NavigationSplitViewColumn = .detail
    
    var body: some View {
        @Bindable var modelData = modelData
        
        NavigationSplitView(preferredCompactColumn: $preferredColumn) {
            List {
                Section {
                    ForEach(CategoryOptions.mainPages) { page in
                        NavigationLink(value: page) {
                            Label(page.name, systemImage: page.iconName)
                        }
                    }
                }
            }
            .navigationDestination(for: CategoryOptions.self) { page in
                NavigationStack(path: $modelData.path) {
                    page.viewForPage()
                }
                
            }
        } detail: {
            NavigationStack(path: $modelData.path) {
                // Vista inicial cuando no se ha seleccionado nada aún
                Text("Selecciona una opción del menú")
                    .foregroundStyle(.secondary)
                    .navigationTitle("iConnect")
                    .navigationDestination(for: CategoryOptions.self) { page in
                        page.viewForPage()
                    }
            }
        }
    }
}



#Preview {
    ContentView()
}



struct CollectionsView: View {
    @Environment(ModelData.self) var modelData
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(modelData.userCollections, id: \.id) { collection in
                    CollectionListItemView(collection: collection)
                        .padding()
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItemGroup {
                toolBarDeleteAll
            }
        }
    }
    
    var toolBarDeleteAll: some View {
        Button {
            // storage.deleteAllRequests()
        } label: {
            Label("Eliminar Todos", systemImage: "trash")
        }
    }
}

struct CollectionListItemView: View {
    let collection: RequestCollection

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(collection.name)
                .font(.title2)
                .bold()
            
            if collection.description.isEmpty == false {
                Text(collection.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Divider()
            
            if collection.request.isEmpty {
                Text("No hay requests en esta colección")
                    .foregroundColor(.gray)
                    .italic()
            } else {
                ForEach(collection.request, id: \.id) { request in
                    VStack(alignment: .leading) {
                        Text(request.title)
                            .font(.headline)
                        Text("\(request.method) - \(request.endpoint)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }
}

