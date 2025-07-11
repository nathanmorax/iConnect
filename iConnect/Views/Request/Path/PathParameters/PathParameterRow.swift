//
//  PathParameterRow.swift
//  iConnect
//
//  Created by Jonathan Mora on 25/06/25.
//
import SwiftUI

struct PathParameterRow: View {

    @ObservedObject var parameter: PathParameterModel

 
    var body: some View {
        Group {
            TextField("name", text: $parameter.name)
            TextField("path", text: $parameter.value)
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
