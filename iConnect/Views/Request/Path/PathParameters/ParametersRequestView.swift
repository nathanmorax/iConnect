//
//  ParametersRequestView.swift
//  iConnect
//
//  Created by Jonathan Mora on 25/06/25.
//
import SwiftUI

struct ParametersRequestView: View {
    
    @Binding var selectedTab: ParametersRequest?

    var body: some View {
        HStack {
            Text("Parameters")
                .font(.system(size: 16, weight: .semibold))
                .multilineTextAlignment(.leading)
            Spacer()
            
        }
        .padding(.top, 32)
        
        HStack {
            ForEach(ParametersRequest.allCases, id: \.self) { tab in
                RequestTabButton(label: tab.name, isSelected: selectedTab == tab) {
                    selectedTab = tab
                }
            }
            Spacer()
        }
        .padding(.top, 12)
        
        VStack(alignment: .leading, spacing: 16) {
            selectedTab?.viewForPage()
        }
        .padding(.top, 16)
    }
}

#Preview {
    PathParametersView()
}
