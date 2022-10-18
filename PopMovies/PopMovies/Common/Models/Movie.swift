//
//  Movie.swift
//  PopMovies
//
//  Created by Angela Alves on 10/10/22.
//

import Foundation

struct MovieResponse: Codable {
    let results: [MovieResponseItem]
}

struct MovieResponseItem: Codable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
    let release_date: String?
    
}

struct Movies {
    let movies: [MovieItem]
}

struct MovieItem: Equatable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String
    let release_date: String


    init(from coreData: FavoriteMovieItem) {
        self.id = Int(coreData.id)
        self.title = coreData.title ?? ""
        self.overview = coreData.overview ?? ""
        self.release_date = coreData.release_date ?? ""
        self.poster_path = coreData.poster_path ?? ""
    }

    init(from response: MovieResponseItem) {
        self.id = Int(response.id)
        self.title = response.title
        self.overview = response.overview
        self.release_date = response.release_date ?? ""
        self.poster_path = response.poster_path ?? ""
    }
}
