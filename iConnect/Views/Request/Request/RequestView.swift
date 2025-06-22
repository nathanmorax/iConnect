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
        VStack(spacing: 8) {
            
            HStack{
                Text("End Point")
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.leading)
                Spacer()

            }
            .padding(.top, 32)
            .padding(.bottom, 12)
                        
            HStack(spacing: 12) {
                MethodMenuButton(selectedMethod: $vm.selectMethod)
                    .padding(.leading, 8)


                TextField("Endpoint", text: $vm.endpoint)
                    .textFieldStyle()

                Button("Send") {
                    vm.sendRequest()
                }
                .buttonStyle(ButtonSendStyle(selectedMethod: $vm.selectMethod))
            }
            .cardStyle()
            
            HStack{
                Text("Request body")
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.leading)
                Spacer()

            }
            .padding(.top, 32)
            .padding(.bottom, 12)


            ResponseViewer(response: $vm.responseText, responseStatusCode: $vm.statusCode, responseTime: $vm.responseTimeMs, highlightedResponse: $vm.highlightedResponse)
                .cardStyle()
            
            Spacer()
            
        }
        .navigationTitle("Request")
        .padding()
        .cornerRadius(8)
        .if(showsToolbar) {
            $0.toolbar {
                ToolbarItemGroup {
                    ReusableToolbar(actions: [
                        .save({
                            isShowingLandmarksSelection.toggle()
                        })
                    ])
                    
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
}

#Preview {
    RequestView(method: "Get", endpoint: "Get")
}
