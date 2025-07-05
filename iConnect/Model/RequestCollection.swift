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
    var auth: [String: String]?
    var headers: [String: String]?
    var parameters: [String: String]?
    
    var thumbnailImageName: String {
        return "\(id)-thumb"
    }
    
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation {
            Image($0.thumbnailImageName)
        }
    }
}
