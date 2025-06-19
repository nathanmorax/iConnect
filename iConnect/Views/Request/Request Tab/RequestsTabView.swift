//
//  RequestsTabView.swift
//  iConnect
//
//  Created by Jonathan Mora on 18/06/25.
//
import SwiftUI

struct RequestsTabView: View {
    let requests: [Request]
    @Binding var selection: Int

    var body: some View {
        VStack(spacing: 16) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Array(requests.enumerated()), id: \.offset) { index, req in
                        let label = req.endpoint.split(separator: "/").last.map(String.init) ?? req.endpoint

                        RequestTabButton(
                            label: label,
                            isSelected: selection == index
                        ) {
                            selection = index
                        }
                        
                    }
                }
                .padding(.horizontal, 38)
            }

            if requests.indices.contains(selection) {
                RequestView(
                    method: requests[selection].method,
                    endpoint: requests[selection].endpoint,
                    showsToolbar: false
                )
            } else {
                Text("Request no válido")
                    .foregroundStyle(.secondary)
            }
        }
        .background(Color.background)
    }
}
