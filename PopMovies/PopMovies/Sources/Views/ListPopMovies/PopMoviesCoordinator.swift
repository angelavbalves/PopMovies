//
//  PopMoviesCoordinator.swift
//  PopMovies
//
//  Created by Angela Alves on 07/11/22.
//

import Foundation
import UIKit

class PopMoviesCoordinator: CoordinatorProtocol {

    var rootViewController: UINavigationController?

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    func start() {
        let popMoviesViewModel = PopMoviesViewModel(coordinator: self)
        let popMoviesViewController = PopMoviesViewController(viewModel: popMoviesViewModel)

        rootViewController?.setViewControllers([popMoviesViewController], animated: false)
    }

    func routeToDetails(of movie: MovieItem, is favorite: Bool) {
        let detailsViewModel = MovieDetailsViewModel(coordinator: self)
        let movieDetailsViewController = MovieDetailsViewController(movie: movie, isFavorite: favorite, viewModel: detailsViewModel)

        rootViewController?.present(movieDetailsViewController, animated: true)
    }


}
