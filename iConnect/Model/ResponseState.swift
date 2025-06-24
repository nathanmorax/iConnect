//
//  ResponseState.swift
//  iConnect
//
//  Created by Jonathan Mora on 23/06/25.
//


import SwiftUI

enum ResponseState {
    case initial
    case invalidURL
    case networkError
    case invalidResponse
    case success
}

extension ResponseState {
    
    init(from responseText: String, statusCode: Int?) {
        let text = responseText.lowercased()
        
        switch true {
        case responseText.isEmpty:
            self = .initial
        case responseText == "Invalid URL":
            self = .invalidURL
        case text.contains("error:"):
            self = .networkError
        case statusCode == nil || (statusCode ?? 0) < 100:
            self = .invalidResponse
        default:
            self = .success
        }
    }
    
    var icon: Image {
        switch self {
        case .initial: return Image(systemName: "antenna.radiowaves.left.and.right")
        case .invalidURL: return Image(systemName: "link.badge.plus")
        case .networkError: return Image(systemName: "wifi.exclamationmark")
        case .invalidResponse: return Image(systemName: "doc.questionmark")
        case .success: return Image(systemName: "checkmark.circle")
        }
    }
    
    var color: Color {
        switch self {
        case .initial: return .blue
        case .invalidURL: return .orange
        case .networkError: return .red
        case .invalidResponse: return .yellow
        case .success: return .green
        }
    }
    
    var title: String {
        switch self {
        case .initial: return "Ready to Send"
        case .invalidURL: return "Invalid URL"
        case .networkError: return "Connection Error"
        case .invalidResponse: return "Invalid Response"
        case .success: return "Success"
        }
    }
    
    var message: String {
        switch self {
        case .initial:
            return "Enter an endpoint and press Send to see the response"
        case .invalidURL:
            return "Please check the URL format and try again"
        case .networkError:
            return "Check your internet connection and try again"
        case .invalidResponse:
            return "The server returned an invalid response"
        case .success:
            return "Request completed successfully"
        }
    }
}
