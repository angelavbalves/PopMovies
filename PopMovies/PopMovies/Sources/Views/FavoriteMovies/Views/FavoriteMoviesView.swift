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

    var movies: [MovieItem] = []
    let removeFavoriteMovie: (_ id: Int) -> Void

    init(removeFavoriteMovie: @escaping (_ id: Int) -> Void) {
        self.removeFavoriteMovie = removeFavoriteMovie
        super.init()
    }

    private lazy var tableView = UITableView() .. {
        $0.delegate = self
        $0.dataSource = self
        $0.register(FavoriteMoviesCell.self, forCellReuseIdentifier: FavoriteMoviesCell.identifier)
        $0.backgroundColor = Theme.currentTheme.color.backgroundColor.rawValue
    }

    override func configureSubviews() {
        addSubview(tableView)
    }

    override func configureConstraints() {
        tableView.edgesToSuperview()
    }

    func popularFavoriteMoviesList(with favoriteMovies: [MovieItem]) {
        movies = favoriteMovies
        tableView.reloadData()
    }
}

extension FavoriteMoviesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

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
            tableView.reloadData()
        }
    }
}
