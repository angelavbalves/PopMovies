//
//  GenresListView.swift
//  PopMovies
//
//  Created by Angela Alves on 21/11/22.
//

import Foundation
import TinyConstraints
import UIKit

class GenresListView: PMView {

    // MARK: - Properties
    private var genres: [Genre] = []

    // MARK: - View
    private lazy var tableView = UITableView() .. {
        $0.delegate = self
        $0.dataSource = self
        $0.register(GenreCell.self, forCellReuseIdentifier: GenreCell.identifier)
        $0.backgroundColor = Theme.currentTheme.color.backgroundColor.rawValue
    }

    // MARK: - Setup
    override func configureSubviews() {
        addSubview(tableView)
    }

    override func configureConstraints() {
        tableView.edgesToSuperview()
    }

    // MARK: - Aux
    func receive(_ genres: [Genre]) {
        self.genres = genres
        tableView.reloadData()
    }
}

// MARK: - TableView Delegate
extension GenresListView: UITableViewDelegate {}

// MARK: - TableView DataSource
extension GenresListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        genres.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GenreCell.identifier, for: indexPath) as! GenreCell
        let genre = genres[indexPath.row]
        cell.setup(genre)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Genres"
    }
}
