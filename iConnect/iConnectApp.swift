//
//  iConnectApp.swift
//  iConnect
//
//  Created by Jonathan Mora on 07/06/25.
//

import SwiftUI

@main
struct iConnectApp: App {

    //@StateObject private var storage = RequestStorage()
    @State private var modelData = ModelData()

    
    var body: some Scene {
        WindowGroup {
            SplitView()
                .environment(modelData)

        }
    }
}
