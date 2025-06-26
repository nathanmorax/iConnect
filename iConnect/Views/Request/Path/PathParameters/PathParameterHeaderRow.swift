//
//  PathParameterHeaderRow.swift
//  iConnect
//
//  Created by Jonathan Mora on 25/06/25.
//
import SwiftUI

struct PathParameterHeaderRow: View {
    var body: some View {
        Group {
            Text("Name")
            Text("Path")
            
        }
        .font(.subheadline.bold())
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, 12)
    }
}
