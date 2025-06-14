//
//  RequestViewModel.swift
//  iConnect
//
//  Created by Jonathan Mora on 07/06/25.
//

import SwiftUI
import Combine

@Observable
class RequestViewModel: ObservableObject {
    
    @Published var responseText: String = ""
    @Published var endpoint: String = ""
    @Published var selectMethod: HTTPMethod = .get
    @Published var statusCode: Int? = nil
    @Published var responseTimeMs: Int? = nil
    
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init(method: String = "GET", endpoint: String = "") {
        self.selectMethod = HTTPMethod(rawValue: method) ?? .get
        self.endpoint = endpoint
    }
    
    func sendRequest() {
        
        
        guard let url = URL(string: endpoint) else {
            responseText = "Invalid URL"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = selectMethod.rawValue
        
        let startTime = Date()
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> String in
                if let httpResponse = result.response as? HTTPURLResponse {
                    DispatchQueue.main.async {
                        self.statusCode = httpResponse.statusCode
                    }
                } else {
                    DispatchQueue.main.async {
                        self.statusCode = nil
                    }
                }
                return String(data: result.data, encoding: .utf8) ?? "Respuesta no válida"
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    let elapsed = Date().timeIntervalSince(startTime)
                    self.responseTimeMs = Int(elapsed * 1000)
                    break
                case .failure(let error):
                    print("Error real:", error.localizedDescription)
                    DispatchQueue.main.async {
                        self.responseText = "Error: \(error.localizedDescription)"
                        self.statusCode = nil
                        self.responseTimeMs = nil
                        
                    }
                }
            }, receiveValue: { [weak self] response in
                self?.responseText = response
            })
            .store(in: &cancellables)
        
    }
}

