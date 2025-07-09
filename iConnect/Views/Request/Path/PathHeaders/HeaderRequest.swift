//
//  HeaderRequest.swift
//  iConnect
//
//  Created by Jonathan Mora on 25/06/25.
//
import SwiftUI

class PathHeaderRequestModel: ObservableObject, Identifiable, Equatable {
    let id: UUID
    @Published var name: String
    @Published var value: String

    init(id: UUID = UUID(), name: String = "", value: String = "") {
        self.id = id
        self.name = name
        self.value = value
    }

    static func == (lhs: PathHeaderRequestModel, rhs: PathHeaderRequestModel) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.value == rhs.value
    }
}




struct HeaderRequest: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 80), spacing: 1),
        GridItem(.flexible(minimum: 60), spacing: 1),
    ]
    
    @Binding var headers: [PathHeaderRequestModel]  // <- arreglo de headers
    
    private var canRemoveHeader: Bool {
        headers.count > 1
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            LazyVGrid(columns: columns, spacing: 4) {
                HeaderRow(key: "Key", value: "Value")
                
                ForEach(headers) { header in
                    PathHeaderRow(header: header)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 8)
                        .onAppear {
                            print("name: \(header.name), value: \(header.value)")
                        }
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
        if !headers.contains(where: { $0.name.isEmpty && $0.value.isEmpty }) {
            withAnimation {
                headers.append(PathHeaderRequestModel())
            }
        }
    }
    
    private func removeHeader() {
        guard canRemoveHeader else { return }
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            headers.removeLast()
        }
    }
}

