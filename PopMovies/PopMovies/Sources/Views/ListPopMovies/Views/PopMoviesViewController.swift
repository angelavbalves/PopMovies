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
        fetchMoreMovies: { [weak self] in
            self?.getPopMovies()
        },
        didTapOnMovie: { [weak self] in
            self?.didTapOnMovieAction($0)
        }
    )

    private lazy var searchBar = UISearchController() .. {
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
        getPopMovies()
        navigationItem.searchController = searchBar
        ThemeManager.addDarkModeObserver(to: self, selector: #selector(chooseTheme))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setImageButton(defaults.bool(forKey: "isDarkMode"))
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
        if isDark {
            defaults.set(true, forKey: "isDarkMode")
            setImageButton(false)
            view.window?.overrideUserInterfaceStyle = .dark
        } else {
            defaults.set(false, forKey: "isDarkMode")
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
                    self?.loadingView.hide()
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
}

extension PopMoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            emptyView.hide()
            return
        }
        loadingView.show()
        viewModel.filterMovies(text) { [weak self] state in
            switch state {
                case .success(let movies):
                    self?.rootView.showSearchResults(movies)
                    self?.loadingView.hide()
                    if movies.isEmpty {
                        guard let icon = UIImage(named: "search") else { return }
                        self?.emptyView.show(
                            icon: icon,
                            message: "There aren't movies\nwith this title!"
                        )
                    }
                case .error(let error):
                    self?.errorView.show(errorState: error)
            }
        }
    }
}

extension PopMoviesViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resignFirstResponder()
        rootView.resetFilteredMovies()
        emptyView.hide()
    }
}
