//
//  FavoriteMoviesCell.swift
//  PopMovies
//
//  Created by Angela Alves on 08/11/22.
//

import Foundation
import Kingfisher
import TinyConstraints
import UIKit

class FavoriteMoviesCell: UITableViewCell {

    static let identifier = "favoriteMovie"

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
        configureConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let stackViewHorizontal = UIStackView() .. {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.alignment = .center
    }

    private let stackViewVertical = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = 8
    }

    private let poster = UIImageView() .. {
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.4
        $0.contentMode = .scaleAspectFit
    }

    private let title = UILabel() .. {
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        $0.numberOfLines = 0
        $0.textColor = .black
    }

    private let overview = UILabel() .. {
        $0.textColor = Theme.currentTheme.color.textColor.rawValue
        $0.numberOfLines = 4
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .justified
    }

    private let releaseDate = UILabel() .. {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .black
        $0.textAlignment = .right
    }

    func setup(for movie: MovieItem) {
        title.text = movie.title
        overview.text = movie.overview
        releaseDate.text = movie.releaseDate
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
        poster.kf.indicatorType = .activity
        poster.kf.setImage(with: url,
                           placeholder: UIImage(named: "posterNotFound"))
    }

    func configureSubviews() {
        backgroundColor = Theme.currentTheme.color.backgroundColor.rawValue
        addSubview(stackViewHorizontal)
        stackViewHorizontal.addArrangedSubview(stackViewVertical)
        stackViewHorizontal.addArrangedSubview(poster)

        stackViewVertical.addArrangedSubview(title)
        stackViewVertical.addArrangedSubview(Separator())
        stackViewVertical.addArrangedSubview(releaseDate)
        stackViewVertical.addArrangedSubview(Separator())
        stackViewVertical.addArrangedSubview(overview)
    }

    func configureConstraints() {
        stackViewHorizontal.edgesToSuperview(insets: .vertical(12) + .horizontal(12))
        poster.width(frame.width * 0.4)
        poster.height(160)
    }
}
