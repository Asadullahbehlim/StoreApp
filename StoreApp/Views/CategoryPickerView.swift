//
//  CategoryPickerView.swift
//  StoreApp
//
//  Created by Asadullah Behlim on 18/04/23.
//

import SwiftUI

struct CategoryPickerView: View {
    
    let client = StoreHTTPClient()
    @State private var categories: [CategoryModel] = []
    @State private var selectedCategory: CategoryModel?
    
    let onSelected: (CategoryModel) -> Void
    
    var body: some View {
        
        Picker("Categories", selection: $selectedCategory) {
            ForEach(categories, id: \.id) { category in
                Text(category.name).tag(Optional(category))
                
            }
        }.onChange(of: selectedCategory, perform: { category in
            if let category {
                onSelected(category)
            }
        })
        .pickerStyle(.wheel)
            .task {
                do {
                   categories = try await client.getAllCategories()
                    selectedCategory = categories.first
                }
                catch {
                    print(error)
                }
            }
    }
}

struct CategoryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPickerView(onSelected: { _ in })
    }
}
