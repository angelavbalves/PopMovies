//
//  MoviesByGenreViewModel.swift
//  PopMovies
//
//  Created by Angela Alves on 22/11/22.
//

import Foundation
import UIKit

class MoviesByGenreViewModel {
    // MARK: - Properties
    private let service: PMService
    private let favoriteService: FavoriteMoviesService
    private var currentPage = 1
    private weak var coordinator: MoviesByGenreCoordinator?
    let genreName: String
    private let id: Int

    // MARK: - Init
    init(
        id: Int,
        genreName: String,
        service: PMService = .live(),
        favoriteService: FavoriteMoviesService = .live(),
        coordinator: MoviesByGenreCoordinator
    ) {
        self.id = id
        self.genreName = genreName
        self.coordinator = coordinator
        self.service = service
        self.favoriteService = favoriteService
    }

    // MARK: - Aux
    func getMovies(_ completion: @escaping (PopMoviesState) -> Void) {
        service.listMoviesByGenre(currentPage, id) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                    case .success(let response):
                        let movies = response.results.map(MovieItem.init)
                        if !movies.isEmpty {
                            self?.currentPage += 1
                        }
                        completion(.success(movies))
                    case .failure(let error):
                        completion(.error(error))
                }
            }
        }
    }

    func routeToDetails(of movie: MovieItem) {
        coordinator?.routeToDetails(of: movie)
    }
}
