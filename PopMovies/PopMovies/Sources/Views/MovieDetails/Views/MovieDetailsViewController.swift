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
    private lazy var detailsView = MovieDetailsView(movie: movie)

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

}
