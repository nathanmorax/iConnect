//
//  PathHeaderRow.swift
//  iConnect
//
//  Created by Jonathan Mora on 25/06/25.
//
import SwiftUI

struct PathHeaderRow: View {
    @Binding var name: String
    @Binding var value: String
    
    
    var body: some View {
        return Group {
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
