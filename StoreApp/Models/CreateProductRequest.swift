//
//  CreateProductRequest.swift
//  StoreApp
//
//  Created by Asadullah Behlim on 20/04/23.
//

import Foundation

struct CreateProductRequest: Encodable {
    let title: String
    let price: Double
    let description: String
    let categoryId: Int
    let images: [URL]?
    
    init(product: ProductModel) {
        title = product.title
        price = product.price
        description = product.description
        categoryId = product.category.id
        images = product.images ?? []
    }
    
}
