//
//  ProductCellView.swift
//  StoreApp
//
//  Created by Asadullah Behlim on 17/04/23.
//

import SwiftUI

struct ProductCellView: View {
    let product: ProductModel
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 10) {
                Text(product.title).bold()
                Text(product.description)
            }
            Spacer()
            Text(product.price, format: .currency(code: "Usd"))
                .padding(5)
                .foregroundColor(.white)
                .background{
                    Color.green
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellView(product: ProductModel(id: 4, title: "Handmade Fresh Table", price: 700, description: "Andy shoes are designed to keeping in...", category: CategoryModel(id: 5, name: "Others", image: "https://placeimg.com/640/480/any?r=0.591926261873231"),
        images: [URL(string: "https://placeimg.com/640/480/any?r=0.9178516507833767")!]))
        .padding(12)
    }
}
