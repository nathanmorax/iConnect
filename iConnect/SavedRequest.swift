//
//  SavedRequest.swift
//  iConnect
//
//  Created by Jonathan Mora on 08/06/25.
//

import SwiftUI

struct Request: Codable, Identifiable, Hashable {
    let id: UUID
    let name: String
    let method: String
    let endpoint: String
    let date: Date
    let collection: String
}

class RequestStorage: ObservableObject {
    @Published var savedRequests: [Request] = []
    
    private let key = "saved_requests"
    
    init() {
        load()
    }
    
    var collections: [String] {
        Array(Set(savedRequests.map(\.collection))).sorted()
    }

    func saveRequest(name: String, method: String, endpoint: String, collection: String) {
        let new = Request(id: UUID(), name: name, method: method, endpoint: endpoint, date: Date(), collection: collection)
        savedRequests.append(new)
        persist()
    }
    
    private func persist() {
        if let data = try? JSONEncoder().encode(savedRequests) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    private func load() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Request].self, from: data) {
            savedRequests = decoded
        }
    }
    
    func deleteAllRequests() {
        savedRequests.removeAll()
        persist()
    }
}

