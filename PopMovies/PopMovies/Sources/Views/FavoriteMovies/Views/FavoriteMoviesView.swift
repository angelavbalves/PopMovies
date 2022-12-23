//
//  FavoriteMoviesView.swift
//  PopMovies
//
//  Created by Angela Alves on 08/11/22.
//

import Foundation
import TinyConstraints
import UIKit

class FavoriteMoviesView: PMView {

    // MARK: - Properties
    private var movies: [MovieItem] = []
    private let removeFavoriteMovie: (_ id: Int) -> Void
    private let didTapOnMovie: (_ movie: MovieItem) -> Void

    // MARK: - View
    private lazy var tableView = UITableView() .. {
        $0.delegate = self
        $0.dataSource = self
        $0.register(FavoriteMoviesCell.self, forCellReuseIdentifier: FavoriteMoviesCell.identifier)
        $0.backgroundColor = Theme.currentTheme.color.backgroundColor.rawValue
    }

    // MARK: - Init
    init(
        removeFavoriteMovie: @escaping (_ id: Int) -> Void,
        didTapOnMovie: @escaping (_ movie: MovieItem) -> Void
    ) {
        self.removeFavoriteMovie = removeFavoriteMovie
        self.didTapOnMovie = didTapOnMovie
        super.init()
    }

    // MARK: - Setup
    override func configureSubviews() {
        addSubview(tableView)
    }

    override func configureConstraints() {
        tableView.edgesToSuperview()
    }

    // MARK: - Aux
    func popularFavoriteMoviesList(with favoriteMovies: [MovieItem]) {
        movies = favoriteMovies
        tableView.reloadData()
    }
}

// MARK: - Table View Delegate
extension FavoriteMoviesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        didTapOnMovie(movie)
    }
}

// MARK: - Table View DatSource
extension FavoriteMoviesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMoviesCell.identifier, for: indexPath) as! FavoriteMoviesCell
        let movie = movies[indexPath.row]
        cell.setup(for: movie)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeFavoriteMovie(movies[indexPath.row].id)
            movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
