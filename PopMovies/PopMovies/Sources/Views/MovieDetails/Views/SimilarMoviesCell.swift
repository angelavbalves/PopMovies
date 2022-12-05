//
//  SimilarMoviesCell.swift
//  PopMovies
//
//  Created by Angela Alves on 26/10/22.
//

import Foundation
import UIKit
import TinyConstraints
import Kingfisher

class SimilarMoviesCell: UICollectionViewCell {

    static let identifier = "similarMoviesCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let imageView = UIImageView() .. {
        $0.contentMode = .scaleAspectFit
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.4
    }

    func configureViews() {
        addSubview(imageView)
    }

    func configureConstraints() {
        imageView.edgesToSuperview()
    }

    func setup(for movie: MovieItem) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, placeholder: UIImage(named: "posterNotFound")!)
    }
}
