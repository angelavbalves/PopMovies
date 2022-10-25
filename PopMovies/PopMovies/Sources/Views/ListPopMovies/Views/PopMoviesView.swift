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

    // MARK: Properties
    var movies: [MovieItem] = []
    var isLoadingMoreMovies = false
    let didTapOnMovie: (_ movie: MovieItem) -> Void

    init(didTapOnMovie: @escaping (_ movie: MovieItem) -> Void) {
        self.didTapOnMovie = didTapOnMovie
        super.init()
        configureSubviews()
        configureConstraints()
    }

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()) .. {
        $0.delegate = self
        $0.dataSource = self
        $0.register(PopMoviesCell.self, forCellWithReuseIdentifier: PopMoviesCell.identifer)
        $0.backgroundColor = Theme.currentTheme.color.backgroundColor.rawValue
        $0.allowsMultipleSelection = true
    }

    override func configureSubviews() {
        addSubview(collectionView)
    }

    override func configureConstraints() {
        collectionView.edgesToSuperview()
    }

    func receive(_ popMovies: [MovieItem]) {
        movies += popMovies
        collectionView.reloadData()
    }
}

extension PopMoviesView: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        didTapOnMovie(movie)
    }
}

extension PopMoviesView: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopMoviesCell.identifer, for: indexPath) as! PopMoviesCell
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.cornerRadius = 8.0

        let movie = movies[indexPath.row]
        cell.setup(for: movie)

        return cell
    }
}

extension PopMoviesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width * 0.45
        return CGSize(width: width, height: width * 1.5)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 25, left: 15, bottom: 15, right: 15)
    }
}
