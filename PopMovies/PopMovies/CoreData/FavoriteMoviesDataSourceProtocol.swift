//
//  FavoriteMoviesDataSourceProtocol.swift
//  PopMovies
//
//  Created by Angela Alves on 10/10/22.
//

import Foundation

protocol FavoriteMoviesDataSourceProtocol {
    func save(movie: MovieItem) throws
    func verifyMovieInCoreData(for id: Int) -> Bool
    func removeMovie(for id: Int) throws
    func removeAllFavoriteMovies() throws
    func fetchAllMovies() -> [MovieItem]
}
