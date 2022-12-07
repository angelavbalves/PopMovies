//
//  MovieDetailsViewController.swift
//  PopMovies
//
//  Created by Angela Alves on 24/10/22.
//

import Foundation
import UIKit

class MovieDetailsViewController: PMViewController {

    // MARK: - ViewModel
    private let viewModel: MovieDetailsViewModel

    // MARK: - View
    private lazy var detailsView = MovieDetailsView(
        movie: viewModel.movie,
        fetchSimilarMovies: { [weak self] in
            self?.getSimilarMovies()
        },
        didTapFavoriteButton: { [weak self] in
            self?.didTapFavoriteButton(for: $0)
        },
        didTapOnMovie: { [weak self] in
            self?.didTapOnMovieAction($0)
        }
    )

    // MARK: - Init
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Life cycle
    override func loadView() {
        view = detailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getSimilarMovies()
        navigationController?.navigationBar.prefersLargeTitles = false
        closeDetailsButton()
    }

    // MARK: - Setup
    func closeDetailsButton() {
        let image = UIImage(systemName: "xmark.circle")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(closeButtonDidTap))
    }

    // MARK: - Aux
    @objc func closeButtonDidTap() {
        navigationController?.dismiss(animated: true)
    }

    func getSimilarMovies() {
        viewModel.getSimilarMovies { [weak self] state in
            switch state {
                case .success(let similarMovies):
                    self?.detailsView.receive(similarMovies)
                case .error:
                    print("Error to get similar movies")
            }
        }
    }

    func didTapOnMovieAction(_ movie: MovieItem) {
        viewModel.showDetailsOfSimilarMovie(of: movie)
    }

    func didTapFavoriteButton(for movie: MovieItem) {
        viewModel.didTapFavoriteButton(for: movie)
    }
}
