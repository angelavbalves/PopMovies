//
//  GenresListCoordinator.swift
//  PopMovies
//
//  Created by Angela Alves on 21/11/22.
//

import Foundation
import UIKit

class GenresListCoordinator: CoordinatorProtocol {

    // MARK: - Properties
    var rootViewController: UINavigationController?
    private var childCoordinator: [CoordinatorProtocol] = []

    // MARK: - Init
    init(
        rootViewController: PMNavigationController = .init()
    ) {
        self.rootViewController = rootViewController
    }

    // MARK: - Start method
    func start() {
        let viewModel = GenresListViewModel(coordinator: self)
        let controller = GenresListViewController(viewModel: viewModel)

        rootViewController?.setViewControllers([controller], animated: false)
    }

    // MARK: - Route
    func routeToList(for id: Int, _ name: String) {
        let coordinator = MoviesByGenreCoordinator(
            id: id,
            name: name,
            parentNavigation: rootViewController
        )

        childCoordinator.append(coordinator)
        coordinator.start()
    }
}
