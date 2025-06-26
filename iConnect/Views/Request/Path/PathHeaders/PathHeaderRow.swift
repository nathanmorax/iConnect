//
//  PathHeaderRow.swift
//  iConnect
//
//  Created by Jonathan Mora on 25/06/25.
//
import SwiftUI

struct PathHeaderRow: View {
    @State var name: String
    @State var value: String
    
    
    var body: some View {
        Group {
            TextField("key", text: $name)
            TextField("value", text: $value)
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
