//
//  FavoriteMoviesViewModel.swift
//  PopMovies
//
//  Created by Angela Alves on 08/11/22.
//

import Foundation
import UIKit

class FavoriteMoviesViewModel {

    var service: PMService
    var favoriteService: FavoriteMoviesService
    var currentPage = 1
    weak var coordinator: PopMoviesCoordinator?

    init(
        service: PMService = .live(),
        favoriteService: FavoriteMoviesService = .live(),
        coordinator: PopMoviesCoordinator
    ) {
        self.coordinator = coordinator
        self.service = service
        self.favoriteService = favoriteService
    }

    func fetchFavoritesMovies() -> [MovieItem] {
        favoriteService.fetchAllMovies()
    }

    func removeFavoriteMovie(for id: Int) {
        favoriteService.removeMovie(id)
    }
}
