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
    var rootViewController: UIViewController? { window.rootViewController }

    var childCoordinator: [CoordinatorProtocol] = []

    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
        window.makeKeyAndVisible()
    }

    func start() {
        window.rootViewController = tabBarController
        setTabBarController()
    }

    func setTabBarController() {
        let popMoviesViewModel = PopMoviesViewModel(coordinator: self)
        let popMoviesViewController = PopMoviesViewController(viewModel: popMoviesViewModel)
        let popularMovies = PMNavigationController(rootViewController: popMoviesViewController)

        let favoritesMovies = PMNavigationController(rootViewController: FavoritesMoviesViewController())
        let listGenres = PMNavigationController(rootViewController: ListGenresViewController())

        tabBarController.setViewControllers([popularMovies, favoritesMovies, listGenres], animated: false)
        tabBarController.configureTabBar()
    }

    func goToDetailsPage() {
        let detailsViewModel = MovieDetailsViewModel(coordinator: self)
        let movieDetailsViewController = MovieDetailsViewController(viewModel: detailsViewModel)

        rootViewController?.present(movieDetailsViewController, animated: true)
    }
}
