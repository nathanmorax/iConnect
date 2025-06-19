//
//  UIButton+Modifiers.swift
//  iConnect
//
//  Created by Jonathan Mora on 17/06/25.
//

import SwiftUI

struct BlueButtonStyle: ButtonStyle {
    
    @Binding var selectedMethod: HTTPMethod

    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(maxWidth: 130)
            //.background(configuration.isPressed ? Color.blue.opacity(0.7) : Color.blue)
            .background(selectedMethod.color)
            .cornerRadius(8)
    }
}
