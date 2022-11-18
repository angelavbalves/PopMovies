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
    func getMovies(_ completion: @escaping (State) -> Void) {
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

    func saveMovieInCoreData(_ movie: MovieItem) {
        favoriteService.saveMovie(movie)
    }

    func removeMovieOfCoreData(for id: Int) {
        favoriteService.removeMovie(id)
    }

    func verifyMovieInCoreData(for id: Int) -> Bool {
        favoriteService.verifyIfMovieIsInCoreData(id)
    }

    func routeToDetails(of movie: MovieItem) {
        coordinator?.routeToDetails(of: movie)
    }
}
