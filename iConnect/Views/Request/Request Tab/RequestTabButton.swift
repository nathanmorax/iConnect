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
                .infoTitleRequestsTabButtonStyle(isSelected: isSelected)
        }
        .buttonStyle(.plain)
    }
}
