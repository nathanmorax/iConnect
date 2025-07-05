//
//  AuthRequestView.swift
//  iConnect
//
//  Created by Jonathan Mora on 25/06/25.
//


//
//  HeaderRequest.swift
//  iConnect
//
//  Created by Jonathan Mora on 25/06/25.
//
import SwiftUI

struct AuthRequestModel: Identifiable {
    let id = UUID()
    var key: String
    var value: String
}


struct AuthRequestView: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 80), spacing: 1),
        GridItem(.flexible(minimum: 60), spacing: 1),
    ]
    
    @State private var auth: [AuthRequestModel] = [
        AuthRequestModel(key: "", value: "")
    ]
    
    
    private var canRemoveHeader: Bool {
        auth.count > 1
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            LazyVGrid(columns: columns, spacing: 4) {
                HeaderRow(key: "Key", value: "Value")
                
                ForEach($auth) { auth in
                    PathHeaderRow(name: auth.key, value: auth.value)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 8)
                    
                }

            }
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(maxWidth: 800)
        
    }
}
