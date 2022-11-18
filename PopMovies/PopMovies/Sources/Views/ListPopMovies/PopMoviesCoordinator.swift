//
//  PopMoviesCoordinator.swift
//  PopMovies
//
//  Created by Angela Alves on 07/11/22.
//

import Foundation
import UIKit

class PopMoviesCoordinator: CoordinatorProtocol {

    // MARK: - Properties
    private var childCoordinator: [CoordinatorProtocol] = []
    var rootViewController: UINavigationController?

    // MARK: - Init
    init(
        rootViewController: PMNavigationController = .init()
    ) {
        self.rootViewController = rootViewController
    }

    // MARK: - Start Method
    func start() {
        let popMoviesViewModel = PopMoviesViewModel(coordinator: self)
        let popMoviesViewController = PopMoviesViewController(viewModel: popMoviesViewModel)

        rootViewController?.setViewControllers([popMoviesViewController], animated: false)
    }

    // MARK: - Route
    func routeToDetails(of movie: MovieItem) {
        let coordinator = MovieDetailsCoordinator(movie: movie, parentNavigation: rootViewController)

        childCoordinator.append(coordinator)
        coordinator.start()
    }
}
