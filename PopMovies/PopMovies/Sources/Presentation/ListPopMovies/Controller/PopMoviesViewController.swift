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
    private var isFiltering: Bool {
        guard let searchBarText = searchController.searchBar.text else { return false }
        return searchBarText.isNotEmpty
    }

    private lazy var isDarkModeSelected = defaults.bool(forKey: "isDarkMode") {
        didSet { configureDarkMode() }
    }

    // MARK: - View
    private lazy var rootView = MovieListView(
        fetchMoreMovies: { [weak self] in
            self?.fetchMoreMovies()
        },
        didTapOnMovie: { [weak self] in
            self?.didTapOnMovieAction($0)
        }
    )

    private lazy var searchController = UISearchController() .. {
        $0.searchBar.placeholder = "Search Movies By Title"
        $0.searchResultsUpdater = self
        $0.searchBar.delegate = self
        $0.resignFirstResponder()
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
        getMovies()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        loadInitialTheme()
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
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: light,
                style: .done,
                target: self,
                action: #selector(chooseTheme)
            )
        }
    }

    private func loadInitialTheme() {
        setImageButton(!isDarkModeSelected)
    }

    private func configureDarkMode() {
        defaults.set(isDarkModeSelected, forKey: "isDarkMode")
        view.window?.overrideUserInterfaceStyle = isDarkModeSelected ? .dark : .light
    }

    @objc func chooseTheme() {
        setImageButton(isDarkModeSelected)
        isDarkModeSelected = !isDarkModeSelected
    }

    // MARK: - Aux
    func fetchMoreMovies() {
        if isFiltering {
            let searchString = searchController.searchBar.text ?? ""
            filterMoviesByTitle(true, with: searchString)
        } else {
            getMovies()
        }
    }

    func getMovies() {
        viewModel.getMovies { [weak self] state in
            switch state {
                case .success(let movies):
                    if movies.isEmpty {
                        guard let icon = UIImage(named: "list") else { return }
                        self?.emptyView.show(
                            icon: icon,
                            message: "We didn't find\nmovies for you!"
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

    func filterMoviesByTitle(_ isPagingFilteredMovies: Bool, with searchBarText: String) {
        viewModel.filterMovies(isPagingFilteredMovies, searchBarText) { [weak self] state in
            switch state {
                case .success(let movies):
                    if movies.isEmpty, !isPagingFilteredMovies {
                        guard let icon = UIImage(named: "search") else { return }
                        self?.emptyView.show(
                            icon: icon,
                            message: "There aren't movies\nwith this title!"
                        )
                    }
                    guard !movies.isEmpty else { return }
                    isPagingFilteredMovies
                        ? self?.rootView.showSearchResults(movies)
                        : self?.rootView.getFilteredMovies(movies)
                    return
                case .error(let error):
                    self?.errorView.show(errorState: error)
            }
        }
    }
}

extension PopMoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            emptyView.hide()
            return
        }
        filterMoviesByTitle(false, with: searchText.sanitized)
        emptyView.hide()
    }
}

extension PopMoviesViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resignFirstResponder()
        rootView.resetFilteredMovies()
        emptyView.hide()
    }
}

extension PopMoviesViewController: ScrollableProtocol {
    func canScrollToTop() -> Bool {
        rootView.collectionView.contentOffset.y > 0
    }

    func scrollToTop() {
        rootView.collectionView.setContentOffset(.zero, animated: true)
    }
}
