//
//  PathParametersView.swift
//  iConnect
//
//  Created by Jonathan Mora on 22/06/25.
//
import SwiftUI


class PathParameterModel: ObservableObject, Identifiable, Equatable {
    let id: UUID
    @Published var name: String
    @Published var value: String

    init(id: UUID = UUID(), name: String = "", value: String = "") {
        self.id = id
        self.name = name
        self.value = value
    }

    static func == (lhs: PathParameterModel, rhs: PathParameterModel) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.value == rhs.value
    }
}

struct PathParametersView: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 80), spacing: 1),
        GridItem(.flexible(minimum: 60), spacing: 1),
    ]
    
    @Binding var parameters: [PathParameterModel]
    
    private var canRemoveParameters: Bool {
        parameters.count > 1
    }
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            LazyVGrid(columns: columns, spacing: 4) {
                HeaderRow(key: "Name", value: "Path")
                
                ForEach(parameters) { param in
                    PathParameterRow(parameter: param)
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
                    addParameter()
                } label: {
                    Image(systemName: "plus")
                        .padding(8)
                }
                .buttonStyle(.plain)
                
                
                if canRemoveParameters {
                    Button {
                        removeParameter()
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
    
    private func addParameter() {
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            parameters.append(PathParameterModel())
        }
        
    }
    
    private func removeParameter() {
        guard canRemoveParameters else { return }
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            parameters.removeLast()
        }
    }
}
