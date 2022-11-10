//
//  FavoriteMoviesService.swift
//  PopMovies
//
//  Created by Angela Alves on 27/10/22.
//

import Foundation
import UIKit

struct FavoriteMoviesService {
    var verifyIfMovieIsInCoreData: (_ id: Int) -> Bool
    var saveMovie: (_ movie: MovieItem) -> Void
    var removeMovie: (_ id: Int) -> Void
    var fetchAllMovies: () -> [MovieItem]
}

extension FavoriteMoviesService {
    static let coreDataStack = PopMoviesCoreDataStack()
    static func live(_ client: FavoriteMoviesDataSourceProtocol = FavoriteMoviesDataSource(coreDataStack: coreDataStack, managedObjectContext: coreDataStack.mainContext)) -> Self {
        .init { id in
            client.verifyMovieInCoreData(for: id)
        } saveMovie: { movie in
            client.save(movie: movie)
        } removeMovie: { id in
            client.removeMovie(for: id)
        } fetchAllMovies: {
            client.fetchAllMovies()
        }
    }
}
