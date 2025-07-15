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
    @State private var selectedTab: ParametersRequest? = nil
    let showsToolbar: Bool
    @State private var collectionName: String = ""
    
    let method: String
    let endpoint: String
    let savedHeaders: [PathHeaderRequestModel]
    
    
    init(
        method: String = "GET",
        endpoint: String = "",
        savedHeaders: [PathHeaderRequestModel] = [],
        showsToolbar: Bool = true
    ) {
        self.method = method
        self.endpoint = endpoint
        self.showsToolbar = showsToolbar
        self.savedHeaders = savedHeaders
        _vm = StateObject(wrappedValue: RequestViewModel(method: method, endpoint: endpoint, savedHeaders: savedHeaders))
    }
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                
                HeaderView(title: "End Point")
                
                HStack(spacing: 12) {
                    MethodMenuButton(selectedMethod: $vm.selectMethod)
                        .padding(.leading, 8)
                    
                    
                    TextField("Endpoint", text: $vm.endpoint)
                        .textFieldStyle()
                    
                    Button("Send") {
                        Task {
                            await vm.sendRequest()
                        }
                    }
                    .buttonStyle(ButtonSendStyle(selectedMethod: $vm.selectMethod))
                }
                .cardStyle()
                
                ParametersRequestView(selectedTab: $selectedTab, headers: $vm.headers, params: $vm.params, auth: $vm.auth)
                
                
                ResponseViewer(response: $vm.responseText, responseStatusCode: $vm.statusCode, responseTime: $vm.responseTimeMs, highlightedResponse: $vm.highlightedResponse)
                    .emptyState(currentResponseState != .success) {
                        EmptyResponseView(state: currentResponseState)
                    }
                
                Spacer()
                
            }
            .padding()
            .cornerRadius(8)
            .if(showsToolbar) {
                $0.toolbar {
                    ToolbarItemGroup {
                        ReusableToolbar(actions: [
                            ToolbarActionModel.save {
                                isShowingLandmarksSelection.toggle()
                            },
                            ToolbarActionModel.importJSON {
                            }
                        ])
                    }
                    
                }
            }
        }
        .sheet(isPresented: $isShowingLandmarksSelection) {
            CollectionSelectionList(
                selectedCollection: $selectedCollection,
                collectionName: $collectionName,
                method: vm.selectMethod.rawValue,
                endpoint: vm.endpoint,
                requestTitle: vm.responseText,
                headers: vm.headers
            )
            .frame(minWidth: 200.0, minHeight: 400.0)
        }
        
       .onChange(of: method) {
            vm.selectMethod = HTTPMethod(rawValue: method) ?? .get
        }
        .onChange(of: endpoint) {
            vm.endpoint = endpoint
        }
        
        .onChange(of: savedHeaders) {
            vm.headers = savedHeaders
        }
        
        var currentResponseState: ResponseState {
            ResponseState(from: vm.responseText, statusCode: vm.statusCode)
        }
        
    }
}


struct HeaderView: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .multilineTextAlignment(.leading)
            Spacer()
            
        }
        .padding(.top, 32)
        .padding(.bottom, 12)
    }
}
