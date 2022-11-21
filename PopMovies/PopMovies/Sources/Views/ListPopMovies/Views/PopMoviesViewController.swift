//
//  PopMoviesViewController.swift
//  PopMovies
//
//  Created by Angela Alves on 10/10/22.
//

import UIKit

class PopMoviesViewController: PMViewController {

    // MARK: -  ViewModel
    private let viewModel: PopMoviesViewModel

    // MARK: - View
    private lazy var rootView = PopMoviesView(
        fetchMoreMovies: getPopMovies,
        didTapOnMovie: didTapOnMovieAction(_:),
        favoriteButtonSelectedAction: buttonSelected(_:),
        favoriteButtonUnselectedAction: buttonUnselected(_:),
        verifyIfMovieIsInCoreData: verifyMovie(_:)
    )

    // MARK: - Init
    init(viewModel: PopMoviesViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Life Cycle
    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pop Movies"
        getPopMovies()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.reloadCollectionView()
    }

    // MARK: - Aux
    func getPopMovies() {
        loadingView.show()
        viewModel.getMovies { [weak self] state in
            switch state {
                case .success(let movies):
                    self?.rootView.receive(movies)
                    self?.loadingView.hide()
                case .error:
                    print("Error to get movies")
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
