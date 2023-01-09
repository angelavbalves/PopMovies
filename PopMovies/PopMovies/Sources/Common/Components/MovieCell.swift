//
//  MovieCell.swift
//  PopMovies
//
//  Created by Angela Alves on 03/01/23.
//

import Foundation
import Kingfisher
import TinyConstraints
import UIKit

class MovieCell: UICollectionViewCell {

    // MARK: - Properties
    static let identifier = "movieCell"
    private var imageDownloadTask: DownloadTask?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubViews()
        configureConstraints()
        backgroundColor = Theme.currentTheme.color.cellBackgroundColor.rawValue
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views
    private let imageView = UIImageView() .. {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8.0
    }

    private let titleLabel = UILabel() .. {
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = Theme.currentTheme.color.textColor.rawValue
    }

    // MARK: - Life cycle
    private func configureSubViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.cornerRadius = 8.0
    }

    private func configureConstraints() {
        imageView.edgesToSuperview()
        titleLabel.edgesToSuperview(insets: .uniform(6))
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.isHidden = true
        titleLabel.text = ""
        imageDownloadTask?.cancel()
        imageDownloadTask = nil
    }


    // MARK: - Setup
    func setup(for movie: MovieItem) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
        imageView.kf.indicatorType = .activity
        imageDownloadTask = imageView.kf.setImage(
            with: url
        ) { [weak self] result in
            switch result {
                case .success:
                    self?.titleLabel.isHidden = true
                    return
                case .failure:
                    self?.titleLabel.isHidden = false
                    self?.titleLabel.text = movie.title
                    return
            }
        }
    }
}
