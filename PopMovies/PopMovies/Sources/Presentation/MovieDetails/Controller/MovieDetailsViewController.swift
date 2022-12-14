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
        movie: viewModel.getMovie(),
        fetchSimilarMovies: { [weak self] in
            self?.getSimilarMovies()
        },
        didTapFavoriteButton: { [weak self] in
            self?.viewModel.didTapFavoriteButton(for: $0)
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Setup
    func setBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain, target: self,
            action: #selector(returnPage)
        )
    }

    // MARK: - Aux

    @objc func returnPage() {
        viewModel.returnPage()
    }

    func getSimilarMovies() {
        viewModel.getSimilarMovies { [weak self] state in
            switch state {
                case .success(let similarMovies):
                    self?.detailsView.receive(similarMovies)
                case .error(let error):
                    self?.errorView.show(errorState: error)
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
