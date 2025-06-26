//
//  PathParameterRow.swift
//  iConnect
//
//  Created by Jonathan Mora on 25/06/25.
//
import SwiftUI

struct PathParameterRow: View {
    @State var name: String
    @State var path: String
 
    var body: some View {
        Group {
            TextField("name", text: $name)
            TextField("path", text: $path)
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
