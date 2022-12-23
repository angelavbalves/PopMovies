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

class MovieDetailsView: PMView, UIScrollViewDelegate {

    var movie: MovieItem
    var isLoadingMoreMovies = false
    let fetchSimilarMovies: () -> Void
    var isFavorite: Bool {
        didSet {
            setImageButton(isFavorite)
        }
    }
    var favoriteButtonSelectedAction: (_ movie: MovieItem) -> Void
    var favoriteButtonUnselectedAction: (_ id: Int) -> Void
    private var similarMovies: [MovieItem] = [] {
        didSet { collectionViewHeight.constant = collectionContentSize }
    }

    private lazy var itemHeight = collectionView.collectionViewLayout.collectionViewContentSize.height
    private lazy var collectionViewHeight: NSLayoutConstraint = collectionView.height(itemHeight)
    private var collectionContentSize: Double {
        let moviesCount = similarMovies.count
        return Double(moviesCount) * itemHeight
    }

    init(
        movie: MovieItem,
        isFavorite: Bool,
        fetchSimilarMovies: @escaping () -> Void,
        favoriteButtonSelectedAction: @escaping (_ movie: MovieItem) -> Void,
        favoriteButtonUnselectedAction: @escaping (_ id: Int) -> Void
    ) {
        self.favoriteButtonUnselectedAction = favoriteButtonUnselectedAction
        self.favoriteButtonSelectedAction = favoriteButtonSelectedAction
        self.fetchSimilarMovies = fetchSimilarMovies
        self.movie = movie
        self.isFavorite = isFavorite
        super.init()
        setupView()
    }

    private lazy var scrollView = UIScrollView() .. {
        $0.delegate = self
    }

    private let stackView = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = 16
    }

    private let titleStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 16
    }

    private let infoStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = 16
    }

    private let poster = UIImageView() .. {
        $0.contentMode = .scaleAspectFit
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.4
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8.0
    }

    private let titleLabel = UILabel() .. {
        $0.font = UIFont.systemFont(ofSize: 22)
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.contentMode = .scaleAspectFit
    }

    private lazy var favoriteButton = PMButton() .. {
        $0.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
    }

    private let overviewLabel = UILabel() .. {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.numberOfLines = 0
        $0.textAlignment = NSTextAlignment.justified
    }

    private let releaseDate = UILabel() .. {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .black
        $0.textAlignment = .right
    }

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()) .. {
        $0.isScrollEnabled = false
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = Theme.currentTheme.color.backgroundColor.rawValue
        $0.register(
            SimilarMoviesCell.self,
            forCellWithReuseIdentifier: SimilarMoviesCell.identifier
        )
        $0.register(
            HeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderCollectionReusableView.identifier
        )
    }

    override func configureSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.addSubview(collectionView)

        stackView.addArrangedSubview(poster)
        stackView.addArrangedSubview(Separator())
        stackView.addArrangedSubview(infoStackView)

        infoStackView.addArrangedSubview(titleStackView)

        infoStackView.addArrangedSubview(overviewLabel)
        infoStackView.addArrangedSubview(Separator())
        infoStackView.addArrangedSubview(releaseDate)
        infoStackView.addArrangedSubview(Separator())

        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(favoriteButton)
    }

    override func configureConstraints() {
        scrollView.edgesToSuperview(usingSafeArea: true)

        stackView.trailing(to: safeAreaLayoutGuide, offset: -16)
        stackView.leading(to: safeAreaLayoutGuide, offset: 16)

        poster.height(256)
        poster.top(to: scrollView, offset: 16)

        collectionView.widthToSuperview()
        collectionView.topToBottom(of: infoStackView)
        collectionView.bottom(to: scrollView)

        favoriteButton.width(to: stackView)
    }

    func setupView() {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
        poster.kf.indicatorType = .activity
        poster.kf.setImage(with: url, placeholder: UIImage(named: "posterNotFound")!)
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        releaseDate.text = "Release date: \(movie.releaseDate ?? "")"
        isFavorite = movie.isFavorite ?? false
    }

    func setImageButton(_ isSelected: Bool) {
        let image = UIImage(systemName: "heart")!
        let imageFill = UIImage(systemName: "heart.fill")!
        isSelected ? favoriteButton.setImage(imageFill, for: .normal) : favoriteButton.setImage(image, for: .normal)
    }

    func receive(_ similarMovies: [MovieItem]) {
        self.similarMovies += similarMovies
        collectionView.reloadData()
        isLoadingMoreMovies = false
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
            fetchSimilarMovies()
        }
    }

    @objc func buttonSelected(_ button: PMButton) {
        setImageButton(button.isSelected)
        if isFavorite {
            isFavorite = false
            favoriteButtonUnselectedAction(movie.id)
        } else {
            isFavorite = true
            favoriteButtonSelectedAction(movie)
        }
    }
}

extension MovieDetailsView: UICollectionViewDelegate {}

extension MovieDetailsView: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        similarMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMoviesCell.identifier, for: indexPath) as! SimilarMoviesCell

        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.cornerRadius = 8.0

        let movie = similarMovies[indexPath.row]
        cell.setup(for: movie)

        return cell
    }
}

extension MovieDetailsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {

        let width = UIScreen.main.bounds.width * 0.45
        return CGSize(width: width, height: width * 1.5)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 25, left: 10, bottom: 15, right: 10)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection _: Int) -> CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: width / 8)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            return collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderCollectionReusableView.identifier,
                for: indexPath
            )
        }

        return UICollectionReusableView()
    }
}
