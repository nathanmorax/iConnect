//
//  MethodMenuButton.swift
//  iConnect
//
//  Created by Jonathan Mora on 07/06/25.
//

import SwiftUI

struct MethodMenuButton: View {
    @Binding var selectedMethod: HTTPMethod

    var body: some View {
        Menu {
            ForEach(HTTPMethod.allCases) { method in
                Button(action: {
                    selectedMethod = method
                }) {
                    Label(method.rawValue, systemImage: selectedMethod == method ? "checkmark" : "")
                }
            }
        } label: {
            Text(selectedMethod.rawValue)
                .font(.headline)
                .foregroundStyle(selectedMethod.color)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
        }
        .frame(maxWidth: 100)

    }
}
