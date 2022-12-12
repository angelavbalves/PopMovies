//
//  MovieDetailsCoordinator.swift
//  PopMovies
//
//  Created by Angela Alves on 13/11/22.
//

import Foundation
import UIKit

class MovieDetailsCoordinator: CoordinatorProtocol {

    // MARK: - Properties
    var rootViewController: PMNavigationController?
    private let parentNavigation: UINavigationController?
    private let movie: MovieItem

    // MARK: - Action
    var didFinish: (() -> Void)?

    // MARK: - Init
    init(
        movie: MovieItem,
        parentNavigation: UINavigationController?
    ) {
        self.movie = movie
        self.parentNavigation = parentNavigation
    }

    // MARK: - Start Method
    func start() {
        let viewModel = MovieDetailsViewModel(movie: movie, coordinator: self)
        let controller = MovieDetailsViewController(viewModel: viewModel)
        rootViewController = PMNavigationController(rootViewController: controller)
        rootViewController?.didFinish = didFinish
        controller.setCloseButton()
        parentNavigation?.present(rootViewController!, animated: true)
    }

    // MARK: - Routes
    func routeToDetails(of movie: MovieItem) {
        let viewModel = MovieDetailsViewModel(movie: movie, coordinator: self)
        let controller = MovieDetailsViewController(viewModel: viewModel)
        controller.setBackButton()
        parentNavigation?.pushViewController(controller, animated: true)
    }

    func showDetailsOfSimilarMovie(of movie: MovieItem) {
        let detailsViewModel = MovieDetailsViewModel(movie: movie, coordinator: self)
        let detailsController = MovieDetailsViewController(viewModel: detailsViewModel)
        rootViewController?.pushViewController(detailsController, animated: true)
    }

    func returnPage() {
        rootViewController?.popViewController(animated: true)
    }
}
