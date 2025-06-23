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
    case body
    
    static let  allTabs: [ParametersRequest] = [.params, .headers, .body]
    
    var name: String {
        switch self {
        case .params:
            return "Params"
        case .headers:
            return "Headers"
        case .body:
            return "Body"
        }
    }
    
    @MainActor
    @ViewBuilder
    func viewForPage() -> some View {
        switch self {
        case .params:
            PathParametersView()
        case .headers:
            PathParametersView()
        case .body:
            PathParametersView()
        }
    }
}
