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
                .padding(.all, 24)
            }

            if requests.indices.contains(selection) {
                RequestView(
                    method: requests[selection].method,
                    endpoint: requests[selection].endpoint,
                    savedHeaders: requests[selection].headers?.map { PathHeaderRequestModel(name: $0.key, value: $0.value) } ?? [],
                    showsToolbar: false
                )

            } else {
                Text("Request no válido")
                    .foregroundStyle(.secondary)
            }
        }
    }
}
