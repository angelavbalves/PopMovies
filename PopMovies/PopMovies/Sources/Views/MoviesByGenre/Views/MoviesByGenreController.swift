//
//  MoviesByGenreController.swift
//  PopMovies
//
//  Created by Angela Alves on 22/11/22.
//

import Foundation
import TinyConstraints
import UIKit

class MoviesByGenreController: PMViewController {

    // MARK: - ViewModel
    private let viewModel: MoviesByGenreViewModel

    // MARK: View
    private lazy var rootView = PopMoviesView(
        fetchMoreMovies: { [weak self] in
            self?.getMoviesByGenre()
        },
        didTapOnMovie: { [weak self] in
            self?.didTapOnMovieAction($0)
        }
    )

    // MARK: - Init
    init(viewModel: MoviesByGenreViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Life Cycle
    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = Theme.currentTheme.color.textColor.rawValue
        title = viewModel.genreName
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMoviesByGenre()
    }

    // MARK: - Aux
    func getMoviesByGenre() {
        viewModel.getMovies { [weak self] state in
            switch state {
                case .success(let movies):
                    if movies.isEmpty {
                        guard let icon = UIImage(named: "search") else { return }
                        self?.emptyView.show(
                            icon: icon,
                            message: "There aren't movies\n this genre here!"
                        )
                    }
                    self?.rootView.receive(movies)
                case .error(let error):
                    self?.errorView.show(errorState: error)
            }
        }
    }

    func didTapOnMovieAction(_ movie: MovieItem) {
        viewModel.routeToDetails(of: movie)
    }
}
