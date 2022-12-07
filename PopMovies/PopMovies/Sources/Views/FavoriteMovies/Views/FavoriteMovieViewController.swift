//
//  FavoriteMoviesViewController.swift
//  PopMovies
//
//  Created by Angela Alves on 20/10/22.
//

import Foundation
import UIKit

class FavoriteMoviesViewController: PMViewController {

    // MARK: - ViewModel
    let viewModel: FavoriteMoviesViewModel

    // MARK: - View
    private lazy var rootView = FavoriteMoviesView(
        removeFavoriteMovie: { [weak self] in
            self?.removeFavoriteMovie(with: $0)
        },
        didTapOnMovie: { [weak self] in
            self?.didTapOnFavoriteMovieAction($0)
        }
    )

    // MARK: - Init
    init(viewModel: FavoriteMoviesViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Life Cycle
    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite Movies"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoriteMoviesAndUpdateView()
    }

    // MARK: - Aux
    func fetchFavoriteMoviesAndUpdateView() {
        let favoriteMovies = viewModel.fetchFavoritesMovies()
        rootView.receive(favoriteMovies)
    }

    func removeFavoriteMovie(with id: Int) {
        viewModel.removeFavoriteMovie(for: id)
    }

    func didTapOnFavoriteMovieAction(_ movie: MovieItem) {
        viewModel.routeToDetails(of: movie)
    }
}
