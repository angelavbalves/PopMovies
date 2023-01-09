//
//  SimilarMoviesEmptyCell.swift
//  PopMovies
//
//  Created by Angela Alves on 09/01/23.
//

import TinyConstraints
import UIKit

final class SimilarMoviesEmptyCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "emptyCell"

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubViews()
        configureConstraints()
        backgroundColor = .clear
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let titleLabel = UILabel() .. {
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
        $0.text = "No similar movies found"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = Theme.currentTheme.color.textColor.rawValue
    }

    // MARK: - Life cycle
    private func configureSubViews() {
        addSubview(titleLabel)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.cornerRadius = 8.0
    }

    private func configureConstraints() {
        titleLabel.edgesToSuperview(excluding: .bottom)
    }
}
