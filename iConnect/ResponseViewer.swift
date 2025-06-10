//
//  ResponseViewer.swift
//  iConnect
//
//  Created by Jonathan Mora on 07/06/25.
//
import SwiftUI

struct ResponseViewer: View {
    
    @Binding var response: String
    @Binding var responseStatusCode: Int?
    @Binding var responseTime: Int?

    var body: some View {
        VStack {
            
            HStack {
                Text("Status: \(responseStatusCode.map(String.init) ?? "No Status")")
                Spacer()
                Text("Time: \(responseTime.map(String.init) ?? "0ms")")
            }
            .padding()
           
            Divider()
                .padding(.top, -16)
            
            ScrollView {
                Text(response.isEmpty ? "No response yet." : response)
                    .font(.system(.body, design: .monospaced))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(.horizontal, 12)
    }
}

#Preview {
    ResponseViewer(response: .constant("Not yet response"), responseStatusCode: .constant(200), responseTime: .constant(120))
}
