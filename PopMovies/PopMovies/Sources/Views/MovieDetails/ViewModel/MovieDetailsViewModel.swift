//
//  MovieDetailsViewModel.swift
//  PopMovies
//
//  Created by Angela Alves on 24/10/22.
//

import Foundation
import UIKit

class MovieDetailsViewModel {

    // MARK: - Properties
    private let service: PMService
    private weak var coordinator: MovieDetailsCoordinator?
    private let movieReference: MovieItem

    private var currentPage = 1
    private var favoriteService: FavoriteMoviesService

    // MARK: - Init
    init(
        movie: MovieItem,
        service: PMService = .live(),
        favoriteService: FavoriteMoviesService = .live(),
        coordinator: MovieDetailsCoordinator
    ) {
        movieReference = movie
        self.service = service
        self.favoriteService = favoriteService
        self.coordinator = coordinator
    }

    // MARK: Aux
    func getSimilarMovies(_ completion: @escaping (PopMoviesState) -> Void) {
        service.similarMovies(movieReference.id, currentPage) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                    case .success(let movieSimilarResponse):
                        let movies = movieSimilarResponse.results.map(MovieItem.init)
                        if !movieSimilarResponse.results.isEmpty {
                            self?.currentPage += 1
                        }
                        completion(.success(movies))
                        return
                    case .failure(let error):
                        completion(.error(error))
                }
            }
        }
    }

    func didTapFavoriteButton(for movie: MovieItem) {
        let isFavorite = favoriteService.verifyIfMovieIsInCoreData(movie.id)
        isFavorite
            ? favoriteService.removeMovie(movie.id)
            : favoriteService.saveMovie(movie)
    }

    func getMovie() -> MovieItem {
        var movie = movieReference
        movie.isFavorite = favoriteService.verifyIfMovieIsInCoreData(movie.id)
        return movie
    }

    func routeToDetails(of movie: MovieItem) {
        coordinator?.routeToDetails(of: movie)
    }

    func showDetailsOfSimilarMovie(of movie: MovieItem) {
        coordinator?.showDetailsOfSimilarMovie(of: movie)
    }

    func returnPage() {
        coordinator?.returnPage()
    }
}
