//
//  SideBarView.swift
//  iConnect
//
//  Created by Jonathan Mora on 07/06/25.
//
import SwiftUI

struct SideBarView: View {
    @Binding var selection: CategoryOptions?
    @Binding var selectedCollectionName: String?
    @EnvironmentObject var storage: RequestStorage

    var body: some View {
        List {
            OutlineGroup(itemsWithCollections, children: \.children) { item in
                Label(item.title, systemImage: item.iconName)
                    .foregroundStyle(isSelected(item) ? .white : .primary)
                    .padding(6)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(isSelected(item) ? Color.accentColor : Color.clear)
                    )
                    .onTapGesture {
                        if let cat = item.category {
                            selection = cat
                            selectedCollectionName = nil
                        } else if item.children == nil {
                            selection = .collections
                            selectedCollectionName = item.title
                        }
                    }

            }
        }
        .listStyle(.sidebar)
        .id(storage.savedRequests.count)

        Spacer()

        UserProfileView()
            .padding(.bottom, 16)
    }

    private var itemsWithCollections: [CategoryModel] {
        sidebarCategories.map { item in
            switch item.category {
            case .collections:
                let uniqueCollections = Set(storage.savedRequests.map { $0.collection })
                let children = uniqueCollections.map { name in
                    CategoryModel(title: name, iconName: "cube", category: nil, children: nil)
                }
                return CategoryModel(title: item.title, iconName: item.iconName, category: item.category, children: children)

            case .favorites:
                return item

            default:
                return item
            }
        }
    }
    
    private func isSelected(_ item: CategoryModel) -> Bool {
        if let category = item.category {
            return category == selection
        } else if item.children == nil {
            return selection == .collections && selectedCollectionName == item.title
        }
        return false
    }

}



struct UserProfileView: View {
    var body: some View {
        HStack {
            Image("icon.profile")
                .resizable()
                .frame(width: 24, height: 24)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("Jonathan Jesus")
                    .font(.footnote)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .onTapGesture {
            // Navegar al perfil, mostrar opciones, etc.
        }
    }
}


#Preview {
    SideBarView(selection: .constant(.collections), selectedCollectionName: .constant(""))
        .listStyle(.sidebar)
}
