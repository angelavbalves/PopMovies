//
//  MovieDetailsView.swift
//  PopMovies
//
//  Created by Angela Alves on 24/10/22.
//

import Foundation
import Kingfisher
import TinyConstraints
import UIKit

class MovieDetailsView: PMView {

    // MARK: -  Properties
    private let movie: MovieItem
    private var isLoadingMoreMovies = false
    private let fetchSimilarMovies: () -> Void
    private let didTapFavoriteButton: (_ movie: MovieItem) -> Void
    private let didTapOnMovie: (_ movie: MovieItem) -> Void
    private var similarMovies: [MovieItem] = [] {
        didSet { similarMovies = similarMovies.uniquesById() }
    }

    // MARK: - Init
    init(
        movie: MovieItem,
        fetchSimilarMovies: @escaping () -> Void,
        didTapFavoriteButton: @escaping (_ movie: MovieItem) -> Void,
        didTapOnMovie: @escaping (_ movie: MovieItem) -> Void
    ) {
        self.didTapFavoriteButton = didTapFavoriteButton
        self.fetchSimilarMovies = fetchSimilarMovies
        self.didTapOnMovie = didTapOnMovie
        self.movie = movie
        super.init()
    }

    // MARK: - Views
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()) .. {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = Theme.currentTheme.color.backgroundColor.rawValue
        $0.register(
            MovieCell.self,
            forCellWithReuseIdentifier: MovieCell.identifier
        )
        $0.register(
            HeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderCollectionReusableView.identifier
        )
        $0.prefetchDataSource = self
    }

    // MARK: - Setup
    override func configureSubviews() {
        addSubview(collectionView)
    }

    override func configureConstraints() {
        collectionView.edgesToSuperview(usingSafeArea: true)
    }

    // MARK: - Aux
    func receive(_ similarMovies: [MovieItem]) {
        self.similarMovies += similarMovies
        collectionView.reloadData()
        isLoadingMoreMovies = false
    }
}

// MARK: - Collection View Delegate
extension MovieDetailsView: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = similarMovies[indexPath.row]
        didTapOnMovie(movie)
    }
}

// MARK: - Collection View DataSource
extension MovieDetailsView: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        similarMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell

        let movie = similarMovies[indexPath.row]
        cell.setup(for: movie)

        return cell
    }
}

// MARK: - Collection View Delegate Flow Layout
extension MovieDetailsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let width = isSmallScreen ? 120 : 160
        let height = isSmallScreen ? 160 : 240
        return CGSize(width: width, height: height)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        8
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 25, left: 35, bottom: 20, right: 35)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection _: Int) -> CGSize {
        calculateHeaderViewSize()
    }

    private func calculateHeaderViewSize() -> CGSize {
        let headerView = HeaderCollectionReusableView()
        headerView.setupView(with: movie, didTapFavoriteButton: { _ in })
        return headerView.systemLayoutSizeFitting(
            CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderCollectionReusableView.identifier,
                for: indexPath
            ) as! HeaderCollectionReusableView

            headerView.setupView(
                with: movie,
                didTapFavoriteButton: { [weak self] in
                    self?.didTapFavoriteButton($0)
                }
            )
            return headerView
        }

        return UICollectionReusableView()
    }
}

