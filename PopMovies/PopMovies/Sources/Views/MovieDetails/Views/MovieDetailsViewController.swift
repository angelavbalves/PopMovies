//
//  MovieDetailsViewController.swift
//  PopMovies
//
//  Created by Angela Alves on 24/10/22.
//

import Foundation
import UIKit

class MovieDetailsViewController: PMViewController {

    let viewModel: MovieDetailsViewModel
    let detailsView = MovieDetailsView()

    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func loadView() {
        view = detailsView
    }

}
