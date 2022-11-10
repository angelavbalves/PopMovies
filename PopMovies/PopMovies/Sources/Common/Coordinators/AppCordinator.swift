//
//  AppCordinator.swift
//  PopMovies
//
//  Created by Angela Alves on 24/10/22.
//

import Foundation
import UIKit

class AppCordinator: CoordinatorProtocol {

    private let tabBarController = TabBarController()
    var rootViewController: UINavigationController? { window.rootViewController as? UINavigationController }

    var childCoordinator: [CoordinatorProtocol] = []

    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
        window.makeKeyAndVisible()
    }

    func start() {
        let navController = UINavigationController(rootViewController: tabBarController)
        navController.navigationBar.isHidden = true
        window.rootViewController = navController
        setTabBarController()
    }

    func setTabBarController() {
        let popularMovies = PMNavigationController(rootViewController: PMViewController())

        let coordinator = PopMoviesCoordinator(rootViewController: popularMovies)
        childCoordinator.append(coordinator)
        coordinator.start()

        let favoriteMoviesViewModel = FavoriteMoviesViewModel(coordinator: coordinator)
        let favoritesMovies = PMNavigationController(rootViewController: FavoritesMoviesViewController(viewModel: favoriteMoviesViewModel))
        let listGenres = PMNavigationController(rootViewController: ListGenresViewController())

        tabBarController.setViewControllers([coordinator.rootViewController!, favoritesMovies, listGenres], animated: false)
        tabBarController.configureTabBar()
    }
}
