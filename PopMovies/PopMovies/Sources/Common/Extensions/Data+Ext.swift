//
//  Data+Ext.swift
//  PopMovies
//
//  Created by Angela Alves on 19/10/22.
//

import Foundation

extension Data {
    func decodeFromApi<T: Decodable>() throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let resultsApi = try decoder.decode(T.self, from: self)
        return resultsApi
    }
}
