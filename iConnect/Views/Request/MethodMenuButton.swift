//
//  MethodMenuButton.swift
//  iConnect
//
//  Created by Jonathan Mora on 07/06/25.
//
import SwiftUI

struct MethodMenuButton: View {
    @Binding var selectedMethod: HTTPMethod
    @State private var showMenu = false
    
    var body: some View {
        Button(action: {
            showMenu.toggle()
        }) {
            HStack(spacing: 4) {
                Text(selectedMethod.rawValue)
                    .foregroundStyle(selectedMethod.color)
                Image(systemName: "chevron.down")
                    .font(.caption)
                    .foregroundStyle(selectedMethod.color)
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 4)
            .background(Color.backgroundPrimary)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            .cornerRadius(8)
        }
        
        .buttonStyle(.plain)
        .popover(isPresented: $showMenu, arrowEdge: .bottom) {
            VStack(alignment: .leading, spacing: 4) {
                ForEach(HTTPMethod.allCases) { method in
                    Button {
                        selectedMethod = method
                        showMenu = false
                    } label: {
                        HStack {
                            Text(method.rawValue)
                                .foregroundColor(.primary)
                            Spacer()
                            if selectedMethod == method {
                                Image(systemName: "checkmark")
                                    .foregroundColor(selectedMethod.color)
                            }
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 8)
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(width: 160)
        }
    }
}

