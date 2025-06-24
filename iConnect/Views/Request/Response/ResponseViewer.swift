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
    @Binding var highlightedResponse: AttributedString
    
    var body: some View {
        
        VStack {
            HeaderView(title: "Response")

            VStack {
                HStack {
                    Text("Status: \(responseStatusCode.map(String.init) ?? "No Status")")
                        .infoTitle2Style()
                    
                    Spacer()
                    Text("Time: \(responseTime.map { "\($0)ms" } ?? "0ms")")
                        .infoTitle2Style(foregroundStyle: .greenColor)
                        .cardStyle(backgroundColor: .green2Color)
                }
                
                Divider()
                
                ScrollView {
                    HStack(alignment: .top) {
                        VStack(alignment: .trailing, spacing: 4) {
                            let lines = response.split(separator: "\n", omittingEmptySubsequences: false)
                            ForEach(0..<lines.count, id: \.self) { index in
                                Text("\(index + 1)")
                                    .font(.system(.caption, design: .monospaced))
                                    .foregroundColor(.grayColor)
                            }
                        }
                        .padding(.trailing, 8)
                       
                        VStack(alignment: .leading, spacing: 0) {
                            Text(highlightedResponse)
                                .font(.system(.caption, design: .monospaced))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .textSelection(.enabled)
                        }

                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 12)
                }
            }
            .padding(.horizontal, 12)
            .cardStyle()
        }
    }
}

#Preview {
    @State var sampleResponse = """
    {
      "name": "John Doe",
      "age": 30,
      "active": true,
      "balance": 1234.56,
      "address": null
    }
    """
    
    @State var highlightedSample = AttributedString("""
    {
      "name": "John Doe",
      "age": 30,
      "active": true,
      "balance": 1234.56,
      "address": null
    }
    """)
    
    return ResponseViewer(
        response: .constant(sampleResponse),
        responseStatusCode: .constant(200),
        responseTime: .constant(120),
        highlightedResponse: .constant(highlightedSample)
    )
}
