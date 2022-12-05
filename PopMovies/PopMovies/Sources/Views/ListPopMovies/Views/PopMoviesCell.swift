//
//  PopMoviesCell.swift
//  PopMovies
//
//  Created by Angela Alves on 20/10/22.
//

import Foundation
import Kingfisher
import TinyConstraints
import UIKit

class PopMoviesCell: UICollectionViewCell {

    static let identifer = "popMoviesCell"
    private var movie: MovieItem?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubViews()
        configureConstraints()
        backgroundColor = Theme.currentTheme.color.cellColor.rawValue
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let stackView = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = 8
    }

    private let imageView = UIImageView() .. {
        $0.contentMode = .scaleAspectFit
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.4
    }

    private let titleStackView = UIStackView() .. {
        $0.axis = .horizontal
    }

    private let titleLabel = UILabel() .. {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.numberOfLines = 0
    }

    private let button = UIButton() .. {
        $0.setContentHuggingPriority(.required, for: .horizontal)
        $0.setCompressionResistance(.required, for: .horizontal)
        let image = UIImage(systemName: "heart")!
        $0.setImage(image, for: .normal)
        $0.tintColor = .black
    }

    func setup(for movie: MovieItem) {
        titleLabel.text = movie.title
        self.movie = movie
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, placeholder: UIImage(named: "posterNotFound")!)
    }

    func configureSubViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleStackView)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(button)
    }

    func configureConstraints() {
        stackView.edgesToSuperview(insets: .top(8) + .left(8) + .right(8) + .bottom(2), usingSafeArea: true)
        imageView.height(frame.height * 0.80)
    }
}
