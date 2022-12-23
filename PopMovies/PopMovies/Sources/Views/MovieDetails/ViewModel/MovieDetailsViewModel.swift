//
//  MovieDetailsViewModel.swift
//  PopMovies
//
//  Created by Angela Alves on 24/10/22.
//

import Foundation
import UIKit

class MovieDetailsViewModel {

    let service: PMService
    weak var coordinator: PopMoviesCoordinator?
    var currentPage = 1
    var favoriteService: FavoriteMoviesService

    init(
        service: PMService = .live(),
        favoriteService: FavoriteMoviesService = .live(),
        coordinator: PopMoviesCoordinator)
    {
        self.service = service
        self.favoriteService = favoriteService
        self.coordinator = coordinator
    }

    func getSimilarMovies(_ id: Int, _ completion: @escaping (State) -> Void) {
        service.similarMovies(id, currentPage) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                    case .success(let movieSimilarResponse):
                        let movies = movieSimilarResponse.results.map(MovieItem.init)
                        if !movieSimilarResponse.results.isEmpty {
                            self?.currentPage += 1
                        }
                        completion(.success(movies))
                    case .failure:
                        completion(.error)
                }
            }
        }
    }

    func saveMovieInCoreData(_ movie: MovieItem) {
        favoriteService.saveMovie(movie)
    }

    func removeMovieOfCoreData(for id: Int) {
        favoriteService.removeMovie(id)
    }
}
