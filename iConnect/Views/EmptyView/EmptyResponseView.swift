//
//  EmptyResponseView.swift
//  iConnect
//
//  Created by Jonathan Mora on 23/06/25.
//
import SwiftUI

struct EmptyResponseView: View {
    let state: ResponseState
    
    var body: some View {
        VStack(spacing: 16) {
            state.icon
                .font(.system(size: 48))
                .foregroundColor(state.color)
            
            Text(state.title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text(state.message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, minHeight: 120)
        .padding()
    }
}
