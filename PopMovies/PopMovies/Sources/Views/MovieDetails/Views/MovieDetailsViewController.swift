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
    let viewModel: MovieDetailsViewModel
    private lazy var detailsView = MovieDetailsView(movie: movie, fetchSimilarMovies: getSimilarMovies)

    init(movie: MovieItem,
        viewModel: MovieDetailsViewModel
    ) {
        self.movie = movie
        self.viewModel = viewModel
        super.init()
    }

    override func loadView() {
        view = detailsView
    }

    override func viewDidLoad() {
        getSimilarMovies()
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

}
