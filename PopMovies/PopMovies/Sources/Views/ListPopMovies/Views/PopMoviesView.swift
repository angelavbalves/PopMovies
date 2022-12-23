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
    private var movies: [MovieItem] = []
    private var isLoadingMoreMovies = false
    private let fetchMoreMovies: () -> Void
    private var favoriteButtonSelectedAction: (_ movie: MovieItem) -> Void
    private var favoriteButtonUnselectedAction: (_ id: Int) -> Void
    private var verifyIfMovieIsInCoreData: (_ id: Int) -> Bool
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
        didTapOnMovie: @escaping (_ movie: MovieItem) -> Void,
        favoriteButtonSelectedAction: @escaping (_ movie: MovieItem) -> Void,
        favoriteButtonUnselectedAction: @escaping (_ id: Int) -> Void,
        verifyIfMovieIsInCoreData: @escaping (_ id: Int) -> Bool
    ) {
        self.fetchMoreMovies = fetchMoreMovies
        self.didTapOnMovie = didTapOnMovie
        self.favoriteButtonSelectedAction = favoriteButtonSelectedAction
        self.favoriteButtonUnselectedAction = favoriteButtonUnselectedAction
        self.verifyIfMovieIsInCoreData = verifyIfMovieIsInCoreData
        super.init()
    }

    // MARK: - Setup
    override func configureSubviews() {
        addSubview(collectionView)
    }

    override func configureConstraints() {
        collectionView.edgesToSuperview()
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
        collectionView.reloadData()
        isLoadingMoreMovies = false
    }

    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

// MARK: - Collection View Delegate
extension PopMoviesView: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var movie = movies[indexPath.row]
        movie.isFavorite = verifyIfMovieIsInCoreData(movie.id)
        didTapOnMovie(movie)
    }
}

// MARK: - Collection View DataSource
extension PopMoviesView: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopMoviesCell.identifer, for: indexPath) as! PopMoviesCell
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.cornerRadius = 8.0

        var movie = movies[indexPath.row]
        let favorite = verifyIfMovieIsInCoreData(movie.id)
        movie.isFavorite = favorite
        cell.setup(for: movie)
        return cell
    }
}

// MARK: - Collection View Delegate Flow Layout
extension PopMoviesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width * 0.45
        return CGSize(width: width, height: width * 1.5)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 25, left: 15, bottom: 15, right: 15)
    }
}
