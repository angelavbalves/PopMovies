//
//  FavoriteMoviesDataSourceProtocol.swift
//  PopMovies
//
//  Created by Angela Alves on 10/10/22.
//

import Foundation

protocol FavoriteMoviesDataSourceProtocol {
    func save(movie: MovieItem)
    func verifyMovieInCoreData(for id: Int) -> Bool
    func removeMovie(for id: Int)
    func removeAllFavoriteMovies() 
    func fetchAllMovies() -> [MovieItem]
}
