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
    
    
    init(method: String = "GET", endpoint: String = "", savedHeaders: [PathHeaderRequestModel] = []) {
        self.selectMethod = HTTPMethod(rawValue: method) ?? .get
        self.endpoint = endpoint
        self.headers = savedHeaders.filter {
            !$0.name.trimmingCharacters(in: .whitespaces).isEmpty ||
            !$0.value.trimmingCharacters(in: .whitespaces).isEmpty
        }
        
        print("🔄 RequestViewModel initialized with headers:")
        dump(self.headers)
    }
    
    
    
    @MainActor
    func sendRequest() async {
        // Validar URL
        guard let url = URL(string: endpoint) else {
            self.responseText = "Invalid URL"
            self.statusCode = nil
            self.responseTimeMs = nil
            self.state = .invalidURL
            return
        }
        
        // Configurar request
        var request = URLRequest(url: url)
        request.httpMethod = selectMethod.rawValue
        
        let startTime = Date()
        
        do {
            // Hacer el request con async/await
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Procesar respuesta en el main thread (ya estamos en @MainActor)
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
            // Manejar errores
            self.responseText = "Error: \(error.localizedDescription)"
            self.statusCode = nil
            self.responseTimeMs = nil
            self.state = .networkError
        }
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
