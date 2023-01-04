//
//  CollectionReusableViews.swift
//  PopMovies
//
//  Created by Angela Alves on 26/10/22.
//

import Foundation
import TinyConstraints
import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "HeaderCollectionReusableView"
    private var movie: MovieItem?
    private var didTapFavoriteButton: ((_ movie: MovieItem) -> Void)?
    private var isFavorite: Bool = false {
        didSet { setImageButton(isFavorite) }
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        configureConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Views
    private let label = UILabel() .. {
        $0.text = "Similar Movies"
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 22.0)
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
        $0.textColor = Theme.currentTheme.color.textColor.rawValue
        $0.contentMode = .scaleAspectFit
        $0.textAlignment = .center
    }

    private lazy var favoriteButton = FavoriteButton() .. {
        $0.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
    }

    private let overviewLabel = UILabel() .. {
        $0.textColor = Theme.currentTheme.color.textColor.rawValue
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.numberOfLines = 0
        $0.textAlignment = NSTextAlignment.justified
    }

    private let releaseDate = UILabel() .. {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = Theme.currentTheme.color.textColor.rawValue
        $0.textAlignment = .right
    }

    //  MARK: - Setup
    func configureSubviews() {
        addSubview(stackView)

        stackView.addArrangedSubview(poster)
        stackView.addArrangedSubview(Separator())
        stackView.addArrangedSubview(infoStackView)

        infoStackView.addArrangedSubview(titleStackView)

        infoStackView.addArrangedSubview(overviewLabel)
        infoStackView.addArrangedSubview(Separator())
        infoStackView.addArrangedSubview(releaseDate)
        infoStackView.addArrangedSubview(Separator())
        infoStackView.addArrangedSubview(label)

        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(favoriteButton)
    }

    func configureConstraints() {
        stackView.trailing(to: safeAreaLayoutGuide, offset: -16)
        stackView.leading(to: safeAreaLayoutGuide, offset: 16)
        stackView.top(to: safeAreaLayoutGuide, offset: 16)
        stackView.bottom(to: safeAreaLayoutGuide, offset: -16)

        poster.height(256)

        label.centerX(to: stackView)
        favoriteButton.width(to: stackView)
    }

    func setupView(
        with movie: MovieItem,
        didTapFavoriteButton: @escaping (_ movie: MovieItem) -> Void
    ) {
        self.movie = movie
        self.didTapFavoriteButton = didTapFavoriteButton
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
        poster.kf.indicatorType = .activity
        poster.kf.setImage(
            with: url,
            options: [.onFailureImage(UIImage(named: "posterNotFound"))]
        )
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        releaseDate.text = "Release date: \(movie.releaseDate ?? "")"
        isFavorite = movie.isFavorite ?? false
    }

    @objc func buttonSelected(_ button: FavoriteButton) {
        guard let favoriteMovie = movie else { return }
        setImageButton(button.isSelected)
        didTapFavoriteButton?(favoriteMovie)
        if isFavorite {
            isFavorite = false
        } else {
            isFavorite = true
        }
    }

    func setImageButton(_ isSelected: Bool) {
        let image = UIImage(systemName: "heart")
        let imageFill = UIImage(systemName: "heart.fill")
        isSelected ? favoriteButton.setImage(imageFill, for: .normal) : favoriteButton.setImage(image, for: .normal)
    }
}
