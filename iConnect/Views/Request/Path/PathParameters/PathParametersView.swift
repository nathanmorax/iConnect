//
//  PathParametersView.swift
//  iConnect
//
//  Created by Jonathan Mora on 22/06/25.
//
import SwiftUI

struct PathParameterModel: Identifiable {
    let id = UUID()
    var name: String
    var path: String
}

struct PathParametersView: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 80), spacing: 1),
        GridItem(.flexible(minimum: 60), spacing: 1),
    ]
    
    @State private var parameters: [PathParameterModel] = [
        PathParameterModel(name: "", path: "")
    ]
    
    private var canRemoveParameters: Bool {
        parameters.count > 1
    }
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            LazyVGrid(columns: columns, spacing: 4) {
                PathParameterHeaderRow()
                
                ForEach(parameters) { param in
                    PathParameterRow(name: param.name,
                                     path: param.path)
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
            parameters.append(PathParameterModel(name: "", path: ""))
        }
        
    }
    
    private func removeParameter() {
        guard canRemoveParameters else { return }
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            parameters.removeLast()
        }
    }
}
