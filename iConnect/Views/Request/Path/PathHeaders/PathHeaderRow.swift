//
//  PathHeaderRow.swift
//  iConnect
//
//  Created by Jonathan Mora on 25/06/25.
//
import SwiftUI

struct PathHeaderRow: View {
    @ObservedObject var header: PathHeaderRequestModel

    
    
    var body: some View {
        return Group {
            TextField("key", text: $header.name)
            TextField("value", text: $header.value)
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
