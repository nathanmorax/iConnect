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
            HStack {
                Text(selectedMethod.rawValue)
                    .foregroundStyle(selectedMethod.color)
                Image(systemName: "chevron.down")
                    .font(.caption)
                    .foregroundColor(selectedMethod.color)

            }
            .font(.headline)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.backgroundSecondary)
            )
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
            .padding(8)
            .frame(width: 160)
        }
    }
}

