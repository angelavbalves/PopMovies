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
    private var isDarkMode: Bool = false {
        didSet {
            setImageButton(isDarkMode)
        }
    }

    // MARK: - View
    private lazy var rootView = PopMoviesView(
        fetchMoreMovies: getPopMovies,
        didTapOnMovie: didTapOnMovieAction(_:),
        favoriteButtonSelectedAction: buttonSelected(_:),
        favoriteButtonUnselectedAction: buttonUnselected(_:),
        verifyIfMovieIsInCoreData: verifyMovie(_:)
    )

    private lazy var searchBar = UISearchController() .. {
        $0.searchBar.placeholder = "Search Movies By Title"
        $0.searchResultsUpdater = self
        $0.searchBar.delegate = self
    }

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
        setImageButton(true)
        navigationItem.searchController = searchBar
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.reloadCollectionView()
    }

    // MARK: - Setup dark mode button
    func setImageButton(_ isSelected: Bool) {
        let light = UIImage(systemName: "sun.max")
        let dark = UIImage(systemName: "moon")
        if isSelected {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: dark,
                style: .done,
                target: self,
                action: #selector(chooseTheme)
            )
            isDark = true
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: light,
                style: .done,
                target: self,
                action: #selector(chooseTheme)
            )
            isDark = false
        }
    }

    @objc func chooseTheme() {
        configureMode(for: appTheme)
        if isDark {
            setImageButton(false)
            view.window?.overrideUserInterfaceStyle = .dark
        } else {
            setImageButton(true)
            view.window?.overrideUserInterfaceStyle = .light
        }
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

extension PopMoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else { return }
        loadingView.show()
        viewModel.filterMovies(text) { [weak self] state in
            switch state {
                case .success(let movies):
                    self?.rootView.showSearchResults(movies)
                    self?.loadingView.hide()
                case .error:
                    print("Error to filter movies by title")
            }
        }
    }
}

extension PopMoviesViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resignFirstResponder()
        rootView.resetFilteredMovies()
    }
}
