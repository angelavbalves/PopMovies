//
//  Movie.swift
//  PopMovies
//
//  Created by Angela Alves on 10/10/22.
//

import Foundation

struct MovieResponse: Codable, Equatable {
    let results: [MovieResponseItem]
}

struct MovieResponseItem: Codable, Equatable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    
}

struct Movies {
    let movies: [MovieItem]
}

struct MovieItem: Equatable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?


    init(from coreData: FavoriteMovieItem) {
        self.id = Int(coreData.id)
        self.title = coreData.title ?? ""
        self.overview = coreData.overview ?? ""
        self.releaseDate = coreData.release_date
        self.posterPath = coreData.poster_path
    }

    init(from response: MovieResponseItem) {
        self.id = Int(response.id)
        self.title = response.title
        self.overview = response.overview
        self.releaseDate = response.releaseDate
        self.posterPath = response.posterPath
    }
}
