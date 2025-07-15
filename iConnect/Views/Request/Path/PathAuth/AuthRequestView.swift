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

class AuthRequestModel: ObservableObject, Identifiable, Equatable {
    let id: UUID
    @Published var name: String
    @Published var value: String

    init(id: UUID = UUID(), name: String = "", value: String = "") {
        self.id = id
        self.name = name
        self.value = value
    }

    static func == (lhs: AuthRequestModel, rhs: AuthRequestModel) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.value == rhs.value
    }
}

struct AuthRequestView: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 80), spacing: 1),
        GridItem(.flexible(minimum: 60), spacing: 1),
    ]
    
    @Binding var auth: [AuthRequestModel]
    
    
    private var canRemoveHeader: Bool {
        auth.count > 1
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            LazyVGrid(columns: columns, spacing: 4) {
                HeaderRow(key: "Key", value: "Value")
                
                ForEach(auth) { auth in
                    AuthRequestRow(auth: auth)
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

struct AuthRequestRow: View {
    @ObservedObject var auth: AuthRequestModel
    
    var body: some View {
        return Group {
            TextField("key", text: $auth.name)
            TextField("value", text: $auth.value)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 12)
        .textFieldStyle(.plain)
        .foregroundStyle(Color.whiteColor)
        .fontWeight(.semibold)
        .background(Color.backgroundSecondary)
        .cardStyle()
    }

}
