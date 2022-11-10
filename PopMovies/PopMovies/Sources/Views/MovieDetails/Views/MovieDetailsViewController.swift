//
//  MovieDetailsViewController.swift
//  PopMovies
//
//  Created by Angela Alves on 24/10/22.
//

import Foundation
import UIKit

class MovieDetailsViewController: PMViewController {

    var movie: MovieItem
    var isFavorite: Bool
    let viewModel: MovieDetailsViewModel
    private lazy var detailsView = MovieDetailsView(
        movie: movie,
        isFavorite: isFavorite,
        fetchSimilarMovies: getSimilarMovies,
        favoriteButtonSelectedAction: buttonSelected(_:),
        favoriteButtonUnselectedAction: buttonUnselected(_:)
    )

    init(movie: MovieItem,
         isFavorite: Bool,
         viewModel: MovieDetailsViewModel)
    {
        self.movie = movie
        self.isFavorite = isFavorite
        self.viewModel = viewModel
        super.init()
        self.movie.isFavorite = self.isFavorite
    }

    override func loadView() {
        view = detailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getSimilarMovies()
        title = "\(movie.title)"
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    func getSimilarMovies() {
        viewModel.getSimilarMovies(movie.id) { [weak self] state in
            switch state {
                case .success(let similarMovies):
                    self?.detailsView.receive(similarMovies)
                case .error:
                    print("Error to get similar movies")
            }
        }
    }

    func didTapOnMovieAction(_ movie: MovieItem, _ isFavorite: Bool) {
        viewModel.coordinator?.routeToDetails(of: movie, is: isFavorite)
    }

    func buttonSelected(_ movie: MovieItem) {
        viewModel.saveMovieInCoreData(movie)
    }

    func buttonUnselected(_ id: Int) {
        viewModel.removeMovieOfCoreData(for: id)
    }
}
