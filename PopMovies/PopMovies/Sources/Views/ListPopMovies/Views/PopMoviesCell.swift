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

    private let imageView = UIImageView() .. {
        $0.contentMode = .scaleAspectFit
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.4
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8.0
    }

    func setup(for movie: MovieItem) {
        self.movie = movie
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, placeholder: UIImage(named: "posterNotFound")!)
    }

    func configureSubViews() {
        addSubview(imageView)
    }

    func configureConstraints() {
        imageView.edgesToSuperview()
        imageView.height(frame.height)
    }
}
