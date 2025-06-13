//
//  ContentView.swift
//  iConnect
//
//  Created by Jonathan Mora on 07/06/25.
//

import SwiftUI

struct SplitView: View {
    @Environment(ModelData.self) var modelData
    @State private var preferredColumn: NavigationSplitViewColumn = .detail
    
    var body: some View {
        @Bindable var modelData = modelData
        
        NavigationSplitView(preferredCompactColumn: $preferredColumn) {
            List {
                Section {
                    ForEach(NavigationOptions.mainPages) { page in
                        NavigationLink(value: page) {
                            Label(page.name, systemImage: page.iconName)
                        }
                    }
                }
            }
            .navigationDestination(for: NavigationOptions.self) { page in
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
                    .navigationDestination(for: NavigationOptions.self) { page in
                        page.viewForPage()
                    }
            }
        }
    }
}

#Preview {
    SplitView()
}
