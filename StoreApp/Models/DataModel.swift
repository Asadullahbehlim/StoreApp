//
//  DataModel.swift
//  StoreApp
//
//  Created by Asadullah Behlim on 13/04/23.
//

import Foundation

struct DataModel: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String
}
