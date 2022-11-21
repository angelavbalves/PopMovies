//
//  AppCordinator.swift
//  PopMovies
//
//  Created by Angela Alves on 24/10/22.
//

import Foundation
import UIKit

class AppCordinator: CoordinatorProtocol {

    // MARK: - Properties
    private let tabBarController = TabBarController()
    var rootViewController: UINavigationController? { window.rootViewController as? UINavigationController }
    private var childCoordinator: [CoordinatorProtocol] = []
    private var window: UIWindow

    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
        window.makeKeyAndVisible()
    }

    // MARK: - Start method
    func start() {
        let navController = UINavigationController(rootViewController: tabBarController)
        navController.navigationBar.isHidden = true
        window.rootViewController = navController
        setTabBarController()
    }

    // MARK: - Setup
    func setTabBarController() {
        let popMoviesCoordinator = PopMoviesCoordinator()
        childCoordinator.append(popMoviesCoordinator)

        let favoriteMoviesCoordinator = FavoriteMoviesCoordinator()
        childCoordinator.append(favoriteMoviesCoordinator)

        let listGenres = PMNavigationController(rootViewController: GenresListViewController())

        tabBarController.setViewControllers(
            [
                popMoviesCoordinator.rootViewController!,
                favoriteMoviesCoordinator.rootViewController!,
                listGenres
            ],
            animated: false
        )
        tabBarController.configureTabBar()
        favoriteMoviesCoordinator.start()
        popMoviesCoordinator.start()
    }
}
