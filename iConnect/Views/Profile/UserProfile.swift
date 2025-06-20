//
//  UserProfile.swift
//  iConnect
//
//  Created by Jonathan Mora on 19/06/25.
//
import SwiftUI

struct UserProfile: View {
    
    var body: some View {
        HStack(spacing: 16) {
            Image("icon.profile")
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .clipShape(Circle())
            
            Text("Jonathan Mora")
                .font(.caption.bold())
                .foregroundColor(.primary)
            Spacer()
        }
        .padding()
        .shadow(radius: 1)
    }
}

#Preview {
    UserProfile()
}

