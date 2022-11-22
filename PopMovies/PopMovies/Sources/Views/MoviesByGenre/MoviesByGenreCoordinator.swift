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
    var rootViewController: UINavigationController?
    private let id: Int
    private let name: String
    private var childCoordinator: [CoordinatorProtocol] = []

    // MARK: - Init
    init(
        id: Int,
        name: String,
        parentNavigation: UINavigationController?
    ) {
        self.id = id
        self.name = name
        rootViewController = parentNavigation
    }

    // MARK: - Start method
    func start() {
        let viewModel = MoviesByGenreViewModel(id: id, name: name, coordinator: self)
        let controller = MoviesByGenreController(viewModel: viewModel)

        rootViewController?.pushViewController(controller, animated: true)
    }

    // MARK: - Routes
    func routeToDetails(of movie: MovieItem) {
        let coordinator = MovieDetailsCoordinator(movie: movie, parentNavigation: rootViewController)

        childCoordinator.append(coordinator)
        coordinator.start()
    }
}
