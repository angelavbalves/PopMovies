//
//  GenresListViewController.swift
//  PopMovies
//
//  Created by Angela Alves on 20/10/22.
//

import Foundation
import UIKit

class GenresListViewController: PMViewController {

    // MARK: - ViewModel
    private let viewModel: GenresListViewModel

    // MARK: - View
    private lazy var listView = GenresListView(
        didTapOnGenre: { [weak self] in
            self?.didTapOnGenreAction($0, $1)
        }
    )

    // MARK: - Init
    init(viewModel: GenresListViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Life Cycle
    override func loadView() {
        view = listView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getGenresList()
    }

    // MARK: - Aux
    func getGenresList() {
        viewModel.getGenresList { [weak self] state in
            switch state {
                case .success(let genres):
                    self?.listView.receive(genres)
                case .error(let error):
                    self?.errorView.show(errorState: error)
            }
        }
    }

    func didTapOnGenreAction(_ id: Int, _ name: String) {
        viewModel.routeToList(for: id, name)
    }
}

extension GenresListViewController: ScrollableProtocol {
    func canScrollToTop() -> Bool {
        listView.tableView.contentOffset.y > 0
    }

    func scrollToTop() {
        listView.tableView.setContentOffset(.zero, animated: true)
    }
}
