//
//  HTTPMethod.swift
//  iConnect
//
//  Created by Jonathan Mora on 07/06/25.
//

import SwiftUI

enum HTTPMethod: String, CaseIterable, Identifiable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
    
    var id: String { rawValue }
    
    var color: Color {
        switch self {
        case .get: return .greenColor
        case .post: return .blueColor
        case .put: return .yellowColor
        case .delete: return .redColor
        default: return .grayColor
        }
    }
}
