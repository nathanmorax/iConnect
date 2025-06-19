//
//  RequestTabButton.swift
//  iConnect
//
//  Created by Jonathan Mora on 18/06/25.
//
import SwiftUI

struct RequestTabButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.caption)
                .bold()
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blueButton : Color.clear)
                .foregroundColor(isSelected ? .black : .primary)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
