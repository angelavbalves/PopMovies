//
//  MovieDetailsView.swift
//  PopMovies
//
//  Created by Angela Alves on 24/10/22.
//

import Foundation
import UIKit
import TinyConstraints
import Kingfisher

class MovieDetailsView: PMView, UIScrollViewDelegate {

    var movie: MovieItem

    init(movie: MovieItem) {
        self.movie = movie
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
        $0.axis = .horizontal
    }

    private let infoStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = 16
    }

    private let poster = UIImageView() .. {
        $0.layer.cornerRadius = 8.0
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }

    private let titleLabel = UILabel() .. {
        $0.font = UIFont.systemFont(ofSize: 22)
        $0.numberOfLines = 0
        $0.textColor = .black
    }

    private let favoriteButton = UIButton() .. {
        $0.setContentHuggingPriority(.required, for: .horizontal)
        let image = UIImage(systemName: "heart")!
        $0.setImage(image, for: .normal)
        $0.tintColor = .black
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
    }

    override func configureSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(poster)
        stackView.addArrangedSubview(Separator())
        stackView.addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(titleStackView)
        titleStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(Separator())
        infoStackView.addArrangedSubview(overviewLabel)
        infoStackView.addArrangedSubview(Separator())
        infoStackView.addArrangedSubview(releaseDate)
        infoStackView.addArrangedSubview(Separator())
        titleStackView.addArrangedSubview(favoriteButton)
    }

    override func configureConstraints() {
        scrollView.edgesToSuperview(usingSafeArea: true)

        stackView.trailing(to: safeAreaLayoutGuide, offset: -16)
        stackView.leading(to: safeAreaLayoutGuide, offset: 16)
        poster.height(256)
        poster.top(to: scrollView, offset: 16)

    }

    func setupView() {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
        poster.kf.indicatorType = .activity
        poster.kf.setImage(with: url, placeholder: UIImage(named: "posterNotFound")!)
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        releaseDate.text = movie.releaseDate
    }
}
