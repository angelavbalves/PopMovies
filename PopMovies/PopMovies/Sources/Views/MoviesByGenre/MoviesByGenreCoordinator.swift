//
//  MoviesByGenreCoordinator.swift
//  PopMovies
//
//  Created by Angela Alves on 22/11/22.
//

import Foundation
import UIKit

class MoviesByGenreCoordinator: CoordinatorProtocol {

    // MARK: - Properties
    var rootViewController: PMNavigationController?
    private let id: Int
    private let genreName: String
    private var childCoordinator: [CoordinatorProtocol] = []

    // MARK: - Init
    init(
        id: Int,
        genreName: String,
        parentNavigation: PMNavigationController?
    ) {
        self.id = id
        self.genreName = genreName
        rootViewController = parentNavigation
    }

    // MARK: - Start method
    func start() {
        let viewModel = MoviesByGenreViewModel(id: id, genreName: genreName, coordinator: self)
        let controller = MoviesByGenreController(viewModel: viewModel)

        rootViewController?.pushViewController(controller, animated: true)
    }

    // MARK: - Routes
    func routeToDetails(of movie: MovieItem) {
        let coordinator = MovieDetailsCoordinator(
            movie: movie,
            parentNavigation: rootViewController
        )
        coordinator.didFinish = { [weak self] in
            self?.childCoordinator.removeAll()
        }
        childCoordinator.append(coordinator)
        coordinator.start()
    }
}
