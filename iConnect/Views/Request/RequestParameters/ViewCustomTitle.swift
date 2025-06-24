//
//  ViewCustomTitle.swift
//  iConnect
//
//  Created by Jonathan Mora on 22/06/25.
//
import SwiftUI

// Modelo
struct PathParameter: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let required: String
    let description: String
}

// Vista principal
struct PathParametersView: View {
    
    let parameters: [PathParameter] = [
        PathParameter(name: "batchID", type: "string", required: "yes", description: "Unique identifier of the batch job")
    ]
    
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 80), spacing: 1),
        GridItem(.flexible(minimum: 60), spacing: 1),
        GridItem(.flexible(minimum: 60), spacing: 1),
        GridItem(.flexible(minimum: 200), spacing: 1)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            LazyVGrid(columns: columns, spacing: 4) {
                PathParameterHeaderRow()
                
                ForEach(parameters) { param in
                    PathParameterRow(param: param)
                }
            }
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
        }
    }
}

struct PathParameterHeaderRow: View {
    var body: some View {
        Group {
            Text("Parameter")
            Text("Type")
            Text("Required")
            Text("Description")
        }
        .font(.subheadline.bold())
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, 12)
    }
}

struct PathParameterRow: View {
    let param: PathParameter

    var body: some View {
        Group {
            Text(param.name)
                .font(.system(.body, design: .monospaced))
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(4)

            Text(param.type)
            Text(param.required)
            Text(param.description)
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        //.overlay(Rectangle().frame(height: 1).foregroundColor(.orange.opacity(0.05)), alignment: .bottom)
    }
}



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
