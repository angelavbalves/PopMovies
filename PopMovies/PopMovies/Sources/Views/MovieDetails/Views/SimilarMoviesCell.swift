//
//  SimilarMoviesCell.swift
//  PopMovies
//
//  Created by Angela Alves on 26/10/22.
//

import Foundation
import Kingfisher
import TinyConstraints
import UIKit

class SimilarMoviesCell: UICollectionViewCell {

    static let identifier = "similarMoviesCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubViews()
        configureConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let imageView = UIImageView() .. {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8.0
    }

    func configureSubViews() {
        addSubview(imageView)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.cornerRadius = 8.0
    }

    func configureConstraints() {
        imageView.edgesToSuperview()
    }

    func setup(for movie: MovieItem) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            options: [.onFailureImage(UIImage(named: "posterNotFound"))]
        )
    }
}
