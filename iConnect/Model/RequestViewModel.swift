//
//  RequestViewModel.swift
//  iConnect
//
//  Created by Jonathan Mora on 07/06/25.
//

import SwiftUI
import Foundation


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


class RequestViewModel: ObservableObject {
    @Published var responseText: String = ""
    @Published var endpoint: String = ""
    @Published var selectMethod: HTTPMethod = .get
    @Published var statusCode: Int? = nil
    @Published var responseTimeMs: Int? = nil
    @Published var highlightedResponse: AttributedString = AttributedString("")
    @Published var state: ResponseState = .initial


    
    init(method: String = "GET", endpoint: String = "") {
        self.selectMethod = HTTPMethod(rawValue: method) ?? .get
        self.endpoint = endpoint
    }
    
    func sendRequest() {
        guard let url = URL(string: endpoint) else {
            DispatchQueue.main.async {
                self.responseText = "Invalid URL"
                self.state = .invalidURL
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = selectMethod.rawValue
        
        let startTime = Date()
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.responseText = "Error: \(error.localizedDescription)"
                    self.statusCode = nil
                    self.responseTimeMs = nil
                    self.state = .networkError
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    self.statusCode = httpResponse.statusCode
                } else {
                    self.statusCode = nil
                }
                
                if let data = data, let text = String(data: data, encoding: .utf8) {
                    self.responseText = text
                    self.highlightedResponse = self.highlightJSONNative(text)
                    self.state = .success
                } else {
                    self.responseText = "Respuesta no válida"
                    self.highlightedResponse = AttributedString("Respuesta no válida")
                    self.state = .invalidResponse
                }

                
                let elapsed = Date().timeIntervalSince(startTime)
                self.responseTimeMs = Int(elapsed * 1000)
            }
        }.resume()
    }
    
    func highlightJSONNative(_ json: String) -> AttributedString {
        var result = AttributedString(json)
        
        let colorPatterns = [
            (pattern: #""[^"]*"(?=\s*:)"#, color: Color.lilacColor),
            (pattern: #"(?<=:\s)"[^"]*""#, color: Color.greenColor),
            (pattern: #"(?<=:\s)(true|false|null)\b"#, color: Color.yellowColor),
            (pattern: #"(?<=:\s)-?\d+\.?\d*"#, color: Color.yellowColor)
        ]
        
        for (pattern, color) in colorPatterns {
            if let regex = try? NSRegularExpression(pattern: pattern) {
                let matches = regex.matches(in: json, range: NSRange(location: 0, length: json.count))
                
                for match in matches {
                    if let range = Range(match.range, in: json),
                       let attributedRange = result.range(of: String(json[range])) {
                        result[attributedRange].foregroundColor = color
                    }
                }
            }
        }
        
        return result
    }
}
