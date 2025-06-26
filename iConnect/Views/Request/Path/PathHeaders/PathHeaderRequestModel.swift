//
//  PathHeaderRequestModel.swift
//  iConnect
//
//  Created by Jonathan Mora on 25/06/25.
//
import SwiftUI

struct PathHeaderRequestModel: Identifiable {
    let id = UUID()
    var name: String
    var value: String
}


struct HeaderRequest: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 80), spacing: 1),
        GridItem(.flexible(minimum: 60), spacing: 1),
    ]
    
    @State private var headers: [PathHeaderRequestModel] = [
        PathHeaderRequestModel(name: "", value: "")
    ]
    var body: some View {
        
        LazyVGrid(columns: columns, spacing: 4) {
            HeaderRow()
            
            ForEach(headers) { header in
                PathHeaderRow(name: header.name, value: header.value)
                .padding(.horizontal, 8)
                .padding(.vertical, 6)

            }
        }
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
        .padding()
        .frame(maxWidth: 800)

    }
}

struct HeaderRow: View {
    var body: some View {
        Group {
            Text("Name")
            Text("Value")

        }
        .font(.subheadline.bold())
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, 12)
    }
}

struct PathHeaderRow: View {
    @State var name: String
    @State var value: String


    var body: some View {
        Group {
            TextField("Name", text: $name)
            TextField("String", text: $value)
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
