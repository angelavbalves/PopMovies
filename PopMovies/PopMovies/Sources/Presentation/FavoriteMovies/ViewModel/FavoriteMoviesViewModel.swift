//
//  FavoriteMoviesViewModel.swift
//  PopMovies
//
//  Created by Angela Alves on 08/11/22.
//

import Foundation
import UIKit

class FavoriteMoviesViewModel {

    // MARK: - Properties
    private let service: PMService
    private let favoriteService: FavoriteMoviesService
    private weak var coordinator: FavoriteMoviesCoordinator?

    // MARK: - Init
    init(
        service: PMService = .live(),
        favoriteService: FavoriteMoviesService = .live(),
        coordinator: FavoriteMoviesCoordinator
    ) {
        self.coordinator = coordinator
        self.service = service
        self.favoriteService = favoriteService
    }

    // MARK: - Aux
    func fetchFavoritesMovies() -> [MovieItem] {
        favoriteService.fetchAllMovies()
    }

    func removeFavoriteMovie(for id: Int) {
        favoriteService.removeMovie(id)
    }

    func routeToDetails(of movie: MovieItem) {
        coordinator?.routeToDetails(of: movie)
    }
}
