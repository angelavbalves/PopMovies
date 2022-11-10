//
//  PopMoviesViewController.swift
//  PopMovies
//
//  Created by Angela Alves on 10/10/22.
//

import UIKit

class PopMoviesViewController: PMViewController {

    let viewModel: PopMoviesViewModel

    private lazy var collectionView = PopMoviesView(
        fetchMoreMovies: getPopMovies,
        didTapOnMovie: didTapOnMovieAction(_:_:),
        favoriteButtonSelectedAction: buttonSelected(_:),
        favoriteButtonUnselectedAction: buttonUnselected(_:),
        verifyIfMovieIsInCoreData: verifyMovie(_:)
    )

    init(viewModel: PopMoviesViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func loadView() {
        view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pop Movies"
        getPopMovies()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadCollectionView()
    }

    func getPopMovies() {
        loadingView.show()
        viewModel.getMovies { [weak self] state in
            switch state {
                case .success(let movies):
                    self?.collectionView.receive(movies)
                    self?.loadingView.hide()
                case .error:
                    print("Error to get movies")
            }
        }
    }

    func didTapOnMovieAction(_ movie: MovieItem, _ favorite: Bool) {
        viewModel.coordinator?.routeToDetails(of: movie, is: favorite)
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
