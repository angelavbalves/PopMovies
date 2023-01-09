//
//  GenreCell.swift
//  PopMovies
//
//  Created by Angela Alves on 21/11/22.
//

import Foundation
import TinyConstraints
import UIKit

class GenreCell: UITableViewCell {

    // MARK: - Identifier
    static let identifier = "genreCell"

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
        configureConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View
    private let stackView = UIStackView() .. {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }

    private let label = UILabel() .. {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.contentMode = .scaleAspectFit
    }

    private let imageChevron = UIImageView() .. {
        let chevron = UIImage(systemName: "chevron.right")
        $0.tintColor = Theme.currentTheme.color.textColor.rawValue
        $0.image = chevron
        $0.contentMode = .scaleAspectFit
    }

    // MARK: - Setup
    func setup(_ genre: Genre) {
        label.text = genre.name
    }

    func configureSubviews() {
        backgroundColor = Theme.currentTheme.color.backgroundColor.rawValue
        addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(imageChevron)
    }

    func configureConstraints() {
        stackView.edgesToSuperview(insets: .vertical(12) + .horizontal(12))
    }
}
