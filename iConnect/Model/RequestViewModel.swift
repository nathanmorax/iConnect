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

    
    init(method: String = "GET", endpoint: String = "") {
        self.selectMethod = HTTPMethod(rawValue: method) ?? .get
        self.endpoint = endpoint
    }
    
    func sendRequest() {
        guard let url = URL(string: endpoint) else {
            DispatchQueue.main.async {
                self.responseText = "Invalid URL"
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
                } else {
                    self.responseText = "Respuesta no válida"
                    self.highlightedResponse = AttributedString("Respuesta no válida")
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
