//
//  UIView+Modifiers.swift
//  iConnect
//
//  Created by Jonathan Mora on 17/06/25.
//
import SwiftUI

struct CardStyle: ViewModifier {
    var cornerRadius: CGFloat = 16
    var backgroundColor: Color = .backgroundSecondary
    
    func body(content: Content) -> some View {
        content
            .padding(.all, 6)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
            )
    }
}

extension View {
    func cardStyle(
        cornerRadius: CGFloat = 8,
        backgroundColor: Color = .backgroundSecondary
    ) -> some View {
        self.modifier(CardStyle(
            cornerRadius: cornerRadius,
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

struct InfoTitle: ViewModifier {
    var foregroundStyle: Color = .whiteColor

    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(foregroundStyle)
    }
}

struct InfoTitle2: ViewModifier {
    
    var foregroundStyle: Color = .whiteColor

    func body(content: Content) -> some View {
        content
            .foregroundColor(foregroundStyle)
            .font(.system(size: 13, weight: .regular))

    }
}

struct InfoTitleCode: ViewModifier {
    
    var foregroundStyle: Color = .grayColor

    func body(content: Content) -> some View {
        content
            .foregroundColor(foregroundStyle)
            .font(.system(.body, design: .monospaced))
            .frame(maxWidth: .infinity, alignment: .leading)

    }
}

struct InfoTitleRequestsTabButtonStyle: ViewModifier {
    let isSelected: Bool

    func body(content: Content) -> some View {
        content
            .infoTitle2Style()
            .foregroundColor(isSelected ? .white : .grayColor)
            .padding(.all, 8)
            .background(isSelected ? Color.grayColor2 : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .overlay(
                Rectangle()
                    .fill(isSelected ? Color.redColor : .clear)
                    .frame(height: 2)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4),
                alignment: .bottom
            )
    }
}



extension View {
    func infoTabButtonStyle(isSelected: Bool) -> some View {
        modifier(InfoTitleRequestsTabButtonStyle(isSelected: isSelected))
    }
    
    func infoTitleStyle(foregroundStyle: Color = .whiteColor) -> some View {
        modifier(InfoTitle(foregroundStyle: foregroundStyle))
    }
    
    func infoTitle2Style(foregroundStyle: Color = .whiteColor) -> some View {
        modifier(InfoTitle2(foregroundStyle: foregroundStyle))
    }
    
    func infoTitleCodeStyle(foregroundStyle: Color = .grayColor) -> some View {
        modifier(InfoTitleCode(foregroundStyle: foregroundStyle))
    }
    
}



struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.plain)
            .foregroundStyle(Color.whiteColor)
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
