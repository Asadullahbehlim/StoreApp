//
//  StoreHTTPClient.swift
//  StoreApp
//
//  Created by Asadullah Behlim on 13/04/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
    case decodingError
}

class StoreHTTPClient {
    
    func getAllCategories() async throws -> [DataModel] {
        
        
        let (data, response) = try await URLSession.shared.data(from: URL.allCategories)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidServerResponse
        }
        
       guard let categories = try? JSONDecoder().decode([DataModel].self, from: data) else {
            throw NetworkError.decodingError
        }
        return categories

    }
    
}