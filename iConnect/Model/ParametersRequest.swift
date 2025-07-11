//
//  ParametersRequest.swift
//  iConnect
//
//  Created by Jonathan Mora on 22/06/25.
//
import SwiftUI

enum ParametersRequest: String, CaseIterable, Hashable {
    case params
    case headers
    case auth
    
    static let  allTabs: [ParametersRequest] = [.params, .headers, .auth]
    
    var name: String {
        switch self {
        case .params:
            return "Params"
        case .headers:
            return "Headers"
        case .auth:
            return "Auth"
        }
    }
    
    @MainActor
    @ViewBuilder
    func viewForPage(
        params: Binding<[PathParameterModel]>,
        headers: Binding<[PathHeaderRequestModel]>
    ) -> some View {
        switch self {
        case .params:
            PathParametersView(parameters: params)
        case .headers:
            HeaderRequest(headers: headers)
        case .auth:
            AuthRequestView()
        }
    }
}
