//
//  iConnectApp.swift
//  iConnect
//
//  Created by Jonathan Mora on 07/06/25.
//

import SwiftUI

@main
struct iConnectApp: App {

    @StateObject private var storage = RequestStorage()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(storage)

        }
    }
}
