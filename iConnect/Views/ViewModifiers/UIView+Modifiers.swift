//
//  UIView+Modifiers.swift
//  iConnect
//
//  Created by Jonathan Mora on 17/06/25.
//
import SwiftUI

struct CardStyle: ViewModifier {
    var cornerRadius: CGFloat = 16
    var shadowRadius: CGFloat = 12
    var backgroundColor: Color = .backgroundSecondary
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .shadow(color: .black.opacity(0.4), radius: shadowRadius, x: 0, y: 4)
            )
            .padding(.horizontal, 24)
    }
}

extension View {
    func cardStyle(
        cornerRadius: CGFloat = 16,
        shadowRadius: CGFloat = 12,
        backgroundColor: Color = .backgroundSecondary
    ) -> some View {
        self.modifier(CardStyle(
            cornerRadius: cornerRadius,
            shadowRadius: shadowRadius,
            backgroundColor: backgroundColor
        ))
    }
}

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
