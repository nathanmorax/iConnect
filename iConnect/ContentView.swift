//
//  ContentView.swift
//  iConnect
//
//  Created by Jonathan Mora on 07/06/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Category? = .collections
    @State private var selectedCollectionName: String? = nil
    @EnvironmentObject var storage: RequestStorage
    @State private var selectedRequest: Request?
    
    var groupedRequests: [String: [Request]] {
        Dictionary(grouping: storage.savedRequests, by: { $0.collection })
    }
    
    var body: some View {
       /* NavigationSplitView {
            SideBarView(selection: $selection, selectedCollectionName: $selectedCollectionName)
                .environmentObject(storage)
            
        } /*content: {
           switch selection {
           case .collections:
           List(selection: $selectedRequest) {
           if let selected = selectedCollectionName {
           Section(header: Text(selected).font(.headline)) {
           ForEach(groupedRequests[selected] ?? []) { request in
           VStack(alignment: .leading) {
           Text(request.name)
           .font(.headline)
           .foregroundStyle(.blue)
           Text("\(request.method) \(request.endpoint)")
           .font(.caption)
           .foregroundColor(.gray)
           }
           .tag(request)
           }
           }
           } else {
           ForEach(groupedRequests.keys.sorted(), id: \.self) { collection in
           Section(header: Text(collection).font(.headline)) {
           ForEach(groupedRequests[collection] ?? []) { request in
           VStack(alignment: .leading) {
           Text(request.name)
           .font(.headline)
           .foregroundStyle(.blue)
           Text("\(request.method) \(request.endpoint)")
           .font(.caption)
           .foregroundColor(.gray)
           }
           .tag(request)
           }
           }
           }
           }
           }
           
           default:
           Text("Selecciona una categoría")
           }
           
           } */detail: {
               switch selection {
               case .collections:
                   if let request = selectedRequest {
                       RequestView(method: request.method, endpoint: request.endpoint)
                   } else {
                       Text("Selecciona una request")
                           .foregroundColor(.secondary)
                   }
               case .request:
                   RequestView()
                       .navigationTitle(selection?.title ?? "Empty")
                       .environmentObject(storage)
               default:
                   Text("Selecciona algo en la lista")
               }
           }*/
        
        NavigationSplitView {
            SideBarView(selection: $selection, selectedCollectionName: $selectedCollectionName)
                .environmentObject(storage)
                .onChange(of: selectedCollectionName) { newCollection in
                    // Cuando cambie la colección, selecciona el primer request para mostrar
                    if let newCollection,
                       let firstRequest = groupedRequests[newCollection]?.first {
                        selectedRequest = firstRequest
                    } else {
                        selectedRequest = nil
                    }
                }
                .onChange(of: selection) { newSelection in
                    // Si cambias categoría que no sea colecciones, limpia selección
                    if newSelection != .collections {
                        selectedCollectionName = nil
                        selectedRequest = nil
                    }
                }

        } detail: {
            // Muestra detalle según selección
            if selection == .request {
                RequestView()
                    .environmentObject(storage)
            } else if selection == .collections {
                if let request = selectedRequest {
                    RequestView(method: request.method, endpoint: request.endpoint)
                } else {
                    Text("Selecciona una request")
                        .foregroundColor(.secondary)
                }
            } else {
                Text("Selecciona una categoría")
            }
        }
    }
    
}



#Preview {
    ContentView()
}



struct CollectionsView: View {
    @StateObject private var storage = RequestStorage()
    
    var body: some View {
        VStack {
            List(storage.savedRequests) { request in
                VStack(alignment: .leading) {
                    Text(request.name)
                        .font(.headline)
                    Text("\(request.method) \(request.endpoint)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Collections")
        }
        .toolbar {
            ToolbarItemGroup {
                toolBarDeleteAll
            }
        }
    }
    
    var toolBarDeleteAll: some View {
        Button {
            storage.deleteAllRequests()
        } label: {
            Label("Eliminar Todos", systemImage: "trash")
        }
    }
}
