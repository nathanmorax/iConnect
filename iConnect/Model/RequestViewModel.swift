//
//  RequestViewModel.swift
//  iConnect
//
//  Created by Jonathan Mora on 07/06/25.
//

import SwiftUI
import Foundation

class RequestViewModel: ObservableObject {
    @Published var responseText: String = ""
    @Published var endpoint: String = ""
    @Published var selectMethod: HTTPMethod = .get
    @Published var statusCode: Int? = nil
    @Published var responseTimeMs: Int? = nil
    @Published var highlightedResponse: AttributedString = AttributedString("")
    @Published var state: ResponseState = .initial
    @Published var headers: [PathHeaderRequestModel]
    @Published var params: [PathParameterModel]
    @Published var auth: [AuthRequestModel]


    
    init(method: String = "GET", endpoint: String = "", savedHeaders: [PathHeaderRequestModel] = [], params: [PathParameterModel]? = nil, auth: [AuthRequestModel]? = nil) {
        self.selectMethod = HTTPMethod(rawValue: method) ?? .get
        self.endpoint = endpoint
        self.headers = savedHeaders.filter {
            !$0.name.trimmingCharacters(in: .whitespaces).isEmpty ||
            !$0.value.trimmingCharacters(in: .whitespaces).isEmpty
        }
        self.params = params ?? []
        self.auth = auth ?? []
        print("🔄 RequestViewModel initialized with headers:")
        //dump(self.headers)
    }
    
    
    
    @MainActor
    func sendRequest() async {
        guard let url = URL(string: endpoint) else {
            self.responseText = "Invalid URL"
            self.statusCode = nil
            self.responseTimeMs = nil
            self.state = .invalidURL
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = selectMethod.rawValue
        
        
        for header in headers {
            let key = header.name.trimmingCharacters(in: .whitespaces)
            let value = header.value.trimmingCharacters(in: .whitespaces)
            if !key.isEmpty && !value.isEmpty {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        print("📦 Headers enviados:")

        
        let startTime = Date()
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                self.statusCode = httpResponse.statusCode
            } else {
                self.statusCode = nil
            }
            
            if let text = String(data: data, encoding: .utf8) {
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
            
        } catch {
            self.responseText = "Error: \(error.localizedDescription)"
            self.statusCode = nil
            self.responseTimeMs = nil
            self.state = .networkError
        }
    }

    // TODO: Handle nested JSON structures like arrays and dictionaries
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
