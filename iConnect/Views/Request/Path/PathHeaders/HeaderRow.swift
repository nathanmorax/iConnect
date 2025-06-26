//
//  HeaderRow.swift
//  iConnect
//
//  Created by Jonathan Mora on 25/06/25.
//
import SwiftUI

struct HeaderRow: View {
    var body: some View {
        Group {
            Text("Key")
            Text("Value")
            
        }
        .font(.subheadline.bold())
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, 12)
    }
}
