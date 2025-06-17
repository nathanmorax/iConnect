//
//  the.swift
//  iConnect
//
//  Created by Jonathan Mora on 12/06/25.
//

import Foundation
import SwiftUI

/// A class the app uses to store and manage model data.
@Observable @MainActor
class ModelData {
    
    // MARK: - Navigation & UI
    var isLandmarkInspectorPresented: Bool = false
    var path: NavigationPath = NavigationPath() {
        didSet {
            if path.count < oldValue.count && isLandmarkInspectorPresented == true {
                isLandmarkInspectorPresented = false
            }
        }
    }
    
    // MARK: - Collections & Requests
    var requestById: [Int: Request] = [:]
    var favoritesCollection: [RequestCollection] = []
    var userCollections: [RequestCollection] = []
    
    // MARK: - Search
    var searchString: String = ""
    
    var allCollections: [RequestCollection] {
        userCollections.sorted { $0.name.localizedCompare($1.name) == .orderedAscending }
    }

    
    // MARK: - Init
    init() {
        loadData()
        
        for collection in userCollections {
            print("Collection: \(collection.name)")
            for request in collection.request {
                print("- \(request.title)")
            }
        }
    }
    
    // MARK: - Load Initial Data
    func loadData() {
        let requestList: [RequestCollection] = RequestCollection.exampleData
        
        // Construye requestById desde todas las colecciones
        for collection in requestList {
            for request in collection.request {
                requestById[request.id] = request
            }
        }
        
        // Luego rellena los request en cada colección a partir de requestIds
        for collection in requestList {
            let requests = request(for: collection.requestIds)
            collection.request = requests
        }
        
        // Favoritos
        guard let favorites = requestList.first(where: { $0.id == 1 }) else {
            fatalError("Favorites collection missing from example data.")
        }
        favoritesCollection = [favorites]
        
        // Colecciones de usuario
        userCollections = requestList.filter { $0.id != 1 }
    }
    
    
    private func request(for requestIds: [Int]) -> [Request] {
        requestIds.compactMap { requestById[$0] }
    }
    
    // MARK: - Collections Management
    func addCollection(nameCollection name: String) -> RequestCollection {
        let nextUserCollectionId = (userCollections.map { $0.id }.max() ?? 1001) + 1
        
        let newCollection = RequestCollection(
            id: nextUserCollectionId,
            name: name,
            description: "",
            requestIds: [],
            request: []
        )
        
        userCollections.append(newCollection)
        return newCollection
    }
    
    // MARK: - Requests Management
    func addRequest(_ request: Request, to collection: RequestCollection) {
        if let index = userCollections.firstIndex(where: { $0.id == collection.id }) {
            // Evitar duplicados
            guard !userCollections[index].requestIds.contains(request.id) else { return }
            
            userCollections[index].request.append(request)
            userCollections[index].requestIds.append(request.id)
            requestById[request.id] = request
        }
    }
    
    func createAndAddRequest(title: String, method: String, endpoint: String, iconName: String = "folder", description: String = "", to collection: RequestCollection) -> Request {
        let newId = (requestById.keys.max() ?? 0) + 1
        let newRequest = Request(
            id: newId,
            title: title,
            iconName: iconName,
            description: description,
            method: method,
            endpoint: endpoint
        )
        addRequest(newRequest, to: collection)
        return newRequest
    }
    
    // MARK: - Favorites Management
    func isFavorite(_ request: Request) -> Bool {
        return favoritesCollection.contains { $0.request.contains(request) }
    }

    func toggleFavoriteCollection(_ collection: RequestCollection) {
        if favoritesCollection.contains(where: { $0.id == collection.id }) {
            removeFavoriteCollection(collection)
        } else {
            addFavoriteCollection(collection)
        }
    }
    
    func addFavoriteCollection(_ collection: RequestCollection) {
        guard !favoritesCollection.contains(where: { $0.id == collection.id }) else { return }
        favoritesCollection.append(collection)
    }

    
    func removeFavoriteCollection(_ collection: RequestCollection) {
        favoritesCollection.removeAll { $0.id == collection.id }
    }
    
}


extension RequestCollection {
    /// The app's sample collection data.
    @MainActor static let exampleData = [
        RequestCollection(
            id: 1,
            name: "User API Requests",
            description: "Requests related to user operations like login and profile.",
            requestIds: [101, 102],
            request: [
                Request(id: 101, title: "Login User", iconName: "lock.fill", description: "Authenticate user credentials.", method: "POST", endpoint: "/api/login"),
                Request(id: 102, title: "Fetch Profile", iconName: "person.crop.circle", description: "Get user profile data.", method: "GET", endpoint: "/api/profile")
            ]
        ),
        RequestCollection(
            id: 4,
            name: "Product API Requests",
            description: "Requests related to product listing and details.",
            requestIds: [201, 202, 203],
            request: [
                Request(id: 201, title: "List Products", iconName: "list.bullet", description: "Fetch list of all products.", method: "GET", endpoint: "/api/products"),
                Request(id: 202, title: "Product Details", iconName: "doc.text.magnifyingglass", description: "Get detailed info about a product.", method: "GET", endpoint: "/api/products/{id}"),
                Request(id: 203, title: "Create Product", iconName: "plus.circle.fill", description: "Add a new product to the catalog.", method: "POST", endpoint: "/api/products")
            ]
        ),
        RequestCollection(
            id: 5, // <-- cambia este ID para que no sea 1
            name: "Another User API Requests",
            description: "Another set of user operations.",
            requestIds: [109, 108],
            request: [
                Request(id: 109, title: "Login User", iconName: "lock.fill", description: "Authenticate user credentials.", method: "POST", endpoint: "/api/login"),
                Request(id: 108, title: "Fetch Profile", iconName: "person.crop.circle", description: "Get user profile data.", method: "GET", endpoint: "/api/profile")
            ]
        )
    ]
}


