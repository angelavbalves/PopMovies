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
    private var popMoviesCurrentPage = 1
    private var filteredMoviesCurrentPage = 1
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
        service.getMovies(popMoviesCurrentPage) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                    case .success(let movieResponse):
                        let movies = movieResponse.results.map(MovieItem.init)
                        if !movieResponse.results.isEmpty {
                            self?.popMoviesCurrentPage += 1
                        }
                        completion(.success(movies))
                    case .failure(let error):
                        completion(.error(error))
                }
            }
        }
    }

    func filterMovies(_ isPagingFilteredMovies: Bool, _ query: String, _ completion: @escaping (PopMoviesState) -> Void) {
        if !isPagingFilteredMovies { filteredMoviesCurrentPage = 1 }
        let sanitizedQuery = query.sanitized
        guard !sanitizedQuery.isEmpty else { return }
        service.searchMovies(filteredMoviesCurrentPage, sanitizedQuery) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        let movies = response.results.map(MovieItem.init)
                        completion(.success(movies))
                        return
                    case .failure(let error):
                        completion(.error(error))
                }
            }
        }
        filteredMoviesCurrentPage += 1
    }

    func routeToDetails(of movie: MovieItem) {
        coordinator?.routeToDetails(of: movie)
    }
}
