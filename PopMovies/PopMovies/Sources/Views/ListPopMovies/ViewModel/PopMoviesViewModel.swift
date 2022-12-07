//
//  PopMoviesViewModel.swift
//  PopMovies
//
//  Created by Angela Alves on 20/10/22.
//

import Foundation
import UIKit

class PopMoviesViewModel {

    // MARK: - Properties
    private let service: PMService
    private let favoriteService: FavoriteMoviesService
    private var currentPage = 1
    private weak var coordinator: PopMoviesCoordinator?

    // MARK: - Init
    init(
        service: PMService = .live(),
        favoriteService: FavoriteMoviesService = .live(),
        coordinator: PopMoviesCoordinator
    ) {
        self.coordinator = coordinator
        self.service = service
        self.favoriteService = favoriteService
    }

    // MARK: - Aux
    func getMovies(_ completion: @escaping (PopMoviesState) -> Void) {
        service.getMovies(currentPage) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                    case .success(let movieResponse):
                        let movies = movieResponse.results.map(MovieItem.init)
                        if !movieResponse.results.isEmpty {
                            self?.currentPage += 1
                        }
                        completion(.success(movies))
                    case .failure:
                        completion(.error)
                }
            }
        }
    }

    func filterMovies(_ query: String, _ completion: @escaping (PopMoviesState) -> Void) {
        service.searchMovies(currentPage, query) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        let movies = response.results.map(MovieItem.init)
                        completion(.success(movies))
                    case .failure:
                        completion(.error)
                }
            }
        }
    }

    func routeToDetails(of movie: MovieItem) {
        coordinator?.routeToDetails(of: movie)
    }
}
