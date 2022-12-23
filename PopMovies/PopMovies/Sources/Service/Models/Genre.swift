//
//  Genre.swift
//  PopMovies
//
//  Created by Angela Alves on 21/11/22.
//

import Foundation

struct GenresResponse: Codable, Equatable {
    let genres: [Genre]
}

struct Genre: Codable, Equatable {
    let id: Int?
    let name: String?
}
