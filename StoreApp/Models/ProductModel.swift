//
//  Product.swift
//  StoreApp
//
//  Created by Asadullah Behlim on 14/04/23.
//

import Foundation

struct ProductModel: Codable {
    let id: Int?
    let title: String
    let price: Double
    let description: String
    let category: CategoryModel
    let images: [URL]?
}

