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
    
    
    private var canRemoveHeader: Bool {
        headers.count > 1
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            LazyVGrid(columns: columns, spacing: 4) {
                HeaderRow()
                
                ForEach(headers) { header in
                    PathHeaderRow(name: header.name, value: header.value)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 8)
                    
                }

            }
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
            HStack {
                Button {
                    addHeader()
                } label: {
                    Image(systemName: "plus")
                        .padding(8)
                }
                .buttonStyle(.plain)
                
                
                if canRemoveHeader {
                    Button {
                        removeHeader()
                    } label: {
                        Image(systemName: "trash.fill")
                            .padding(8)
                    }
                    .buttonStyle(.plain)
                }
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(maxWidth: 800)
        
    }
    private func addHeader() {
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            headers.append(PathHeaderRequestModel(name: "", value: ""))
        }
        
    }
    
    private func removeHeader() {
        guard canRemoveHeader else { return }
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            headers.removeLast()
        }
    }
}
