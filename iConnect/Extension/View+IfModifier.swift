//
//  View+IfModifier.swift
//  iConnect
//
//  Created by Jonathan Mora on 16/06/25.
//
import SwiftUI


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
