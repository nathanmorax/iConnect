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
    let showsToolbar: Bool

    
    let method: String
    let endpoint: String
    
    init(method: String = "GET", endpoint: String = "", showsToolbar: Bool = true) {
        self.method = method
        self.endpoint = endpoint
        self.showsToolbar = showsToolbar
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
        .if(showsToolbar) {
            $0.toolbar {
                ToolbarItemGroup {
                    toolBarSaveRequest

                }
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

