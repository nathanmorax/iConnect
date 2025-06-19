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


// Title ViewModifier
struct InfoTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundStyle(Color.secondaryLabel)
    }
}

struct DetailedInfoTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.callout)
            .foregroundStyle(.secondary)
    }
}

struct InfoTitleRequestsTabButtonStyle: ViewModifier {
    let isSelected: Bool

    func body(content: Content) -> some View {
        content
            .font(.caption)
            .bold()
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? Color.blueButton : Color.clear)
            .foregroundColor(isSelected ? .black : .primary)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

extension Text {
    func detailedInfoTitle() -> some View {
        modifier(DetailedInfoTitleModifier())
    }
    func infoTitle() -> some View {
        modifier(InfoTitleModifier())
    }
    
    func infoTitleRequestsTabButtonStyle(isSelected: Bool) -> some View {
        modifier(InfoTitleRequestsTabButtonStyle(isSelected: isSelected))
    }
}


struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.plain)
            .foregroundStyle(Color.labelPrimary)
            .fontWeight(.semibold)
            .background(Color.backgroundSecondary)
    }
}

extension TextField {
    func textFieldStyle() -> some View {
        modifier(TextFieldStyle())
    }
}

struct ButtonHTTPStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.backgroundSecondary)
            )
    }
}

struct ButtonSendStyle: ButtonStyle {
    
    @Binding var selectedMethod: HTTPMethod

    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(maxWidth: 130)
            .background(selectedMethod.color)
            .cornerRadius(8)
    }
}
