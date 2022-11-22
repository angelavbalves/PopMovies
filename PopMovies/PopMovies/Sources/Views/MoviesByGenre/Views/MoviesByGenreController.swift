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
        fetchMoreMovies: getMoviesByGenre,
        didTapOnMovie: didTapOnMovieAction(_:),
        favoriteButtonSelectedAction: buttonSelected(_:),
        favoriteButtonUnselectedAction: buttonUnselected(_:),
        verifyIfMovieIsInCoreData: verifyMovie(_:)
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
        navigationController?.navigationBar.tintColor = .black
        title = "\(viewModel.name)"
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
                    self?.rootView.receive(movies)
                case .error:
                    print("Error to get movies by genre")
            }
        }
    }

    func didTapOnMovieAction(_ movie: MovieItem) {
        viewModel.routeToDetails(of: movie)
    }

    func buttonSelected(_ movie: MovieItem) {
        viewModel.saveMovieInCoreData(movie)
    }

    func buttonUnselected(_ id: Int) {
        viewModel.removeMovieOfCoreData(for: id)
    }

    func verifyMovie(_ id: Int) -> Bool {
        viewModel.verifyMovieInCoreData(for: id)
    }
}
