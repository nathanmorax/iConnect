//
//  SavedRequest.swift
//  iConnect
//
//  Created by Jonathan Mora on 08/06/25.
//

import SwiftUI

@Observable
class RequestCollection: Identifiable {
    var id: Int
    var name: String
    var description: String
    var requestIds: [Int]
    var request: [Request] = []
    
    init(id: Int, name: String, description: String, requestIds: [Int], request: [Request] = []) {
        self.id = id
        self.name = name
        self.description = description
        self.requestIds = requestIds
        self.request = request
    }
}
extension RequestCollection: Equatable {
    static func == (lhs: RequestCollection, rhs: RequestCollection) -> Bool {
        return lhs.id == rhs.id
    }
}
extension RequestCollection: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


struct Request: Hashable, Identifiable, Transferable {
    var id: Int
    var title: String
    var iconName: String
    var description: String
    var method: String
    var endpoint: String
    
    var thumbnailImageName: String {
        return "\(id)-thumb"
    }
    
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation {
            Image($0.thumbnailImageName)
        }
    }
}



/*class RequestStorage: ObservableObject {
    @Published var savedRequests: [RequestCollection] = []
    
    private let key = "saved_requests"
    
    init() {
        load()
    }
    
    var collections: [String] {
        Array(Set(savedRequests.map(\.collection))).sorted()
    }

    func saveRequest(name: String, method: String, endpoint: String, collection: String) {
        let new = RequestCollection(id: UUID(), name: name, method: method, endpoint: endpoint, date: Date(), collection: collection)
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
           let decoded = try? JSONDecoder().decode([RequestCollection].self, from: data) {
            savedRequests = decoded
        }
    }
    
    func deleteAllRequests() {
        savedRequests.removeAll()
        persist()
    }
}
*/
