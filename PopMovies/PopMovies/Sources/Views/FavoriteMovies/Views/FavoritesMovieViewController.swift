//
//  FavoritesMoviesViewController.swift
//  PopMovies
//
//  Created by Angela Alves on 20/10/22.
//

import Foundation
import UIKit

class FavoritesMoviesViewController: PMViewController {

    let viewModel: FavoriteMoviesViewModel

    private lazy var tableView = FavoriteMoviesView(removeFavoriteMovie: removeFavoriteMovie(for:))

    override func loadView() {
        view = tableView
    }

    init(viewModel: FavoriteMoviesViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        title = "Favorite Movies"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let favoriteMovies = getFavoriteMovies()
        tableView.popularFavoriteMoviesList(with: favoriteMovies)
    }

    func getFavoriteMovies() -> [MovieItem] {
        viewModel.fetchFavoritesMovies()
    }

    func removeFavoriteMovie(for id: Int) {
        viewModel.removeFavoriteMovie(for: id)
    }
}
