//
//  FavoriteMoviesCoordinator.swift
//  PopMovies
//
//  Created by Angela Alves on 11/11/22.
//
import Foundation
import UIKit

class FavoriteMoviesCoordinator: CoordinatorProtocol {

    // MARK: - Properties
    var rootViewController: PMNavigationController?
    private var childCoordinator: [CoordinatorProtocol] = []

    // MARK: - Init
    init(rootViewController: PMNavigationController = .init()) {
        self.rootViewController = rootViewController
    }

    // MARK: - Start method
    func start() {
        let favoriteMoviesViewModel = FavoriteMoviesViewModel(coordinator: self)
        let favoriteMoviesViewController = FavoriteMoviesViewController(viewModel: favoriteMoviesViewModel)

        rootViewController?.setViewControllers([favoriteMoviesViewController], animated: false)
    }

    // MARK: - Route
    func routeToDetails(of movie: MovieItem) {
        let coordinator = MovieDetailsCoordinator(movie: movie, parentNavigation: rootViewController)

        childCoordinator.append(coordinator)
        coordinator.start()
    }
}
