//
//  PopMoviesView.swift
//  PopMovies
//
//  Created by Angela Alves on 20/10/22.
//

import Foundation
import TinyConstraints
import UIKit

class PopMoviesView: PMView {

    // MARK: - Properties
    private var movies: [MovieItem] = [] {
        didSet { filteredMovies = movies }
    }
    private var filteredMovies: [MovieItem] = [] {
        didSet { collectionView.reloadData() }
    }
    private var isLoadingMoreMovies = false
    private let fetchMoreMovies: () -> Void
    private let didTapOnMovie: (_ movie: MovieItem) -> Void

    // MARK: - View
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()) .. {
        $0.delegate = self
        $0.dataSource = self
        $0.register(PopMoviesCell.self, forCellWithReuseIdentifier: PopMoviesCell.identifer)
        $0.backgroundColor = Theme.currentTheme.color.backgroundColor.rawValue
        $0.allowsMultipleSelection = true
    }

    // MARK: - Init
    init(
        fetchMoreMovies: @escaping () -> Void,
        didTapOnMovie: @escaping (_ movie: MovieItem) -> Void
    ) {
        self.fetchMoreMovies = fetchMoreMovies
        self.didTapOnMovie = didTapOnMovie
        super.init()
    }

    // MARK: - Setup
    override func configureSubviews() {
        addSubview(collectionView)
    }

    override func configureConstraints() {
        collectionView.edgesToSuperview(usingSafeArea: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        let distanceFromBottom = contentHeight - offsetY

        if
            !isLoadingMoreMovies,
            contentHeight > height,
            distanceFromBottom < height
        {
            isLoadingMoreMovies = true
            fetchMoreMovies()
        }
    }

    // MARK: - Aux
    func receive(_ popMovies: [MovieItem]) {
        movies += popMovies
        isLoadingMoreMovies = false
    }

    func reloadCollectionView() {
        collectionView.reloadData()
    }

    func showSearchResults(_ results: [MovieItem]) {
        filteredMovies = results
    }

    func resetFilteredMovies() {
        filteredMovies = movies
    }
}

// MARK: - Collection View Delegate
extension PopMoviesView: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = filteredMovies[indexPath.row]
        didTapOnMovie(movie)
    }
}

// MARK: - Collection View DataSource
extension PopMoviesView: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        filteredMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopMoviesCell.identifer, for: indexPath) as! PopMoviesCell

        let movie = filteredMovies[indexPath.row]
        cell.setup(for: movie)
        return cell
    }
}

// MARK: - Collection View Delegate Flow Layout
extension PopMoviesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 240)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 25, left: 35, bottom: 15, right: 35)
    }
}
