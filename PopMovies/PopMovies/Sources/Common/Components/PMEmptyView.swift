//
//  PMEmptyView.swift
//  PopMovies
//
//  Created by Angela Alves on 09/12/22.
//

import Foundation
import TinyConstraints
import UIKit

class PMEmptyView: PMView {

    // MARK: - Init
    override init() {
        super.init()
        isHidden = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View
    private let stackView = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = 4
    }

    private let label = UILabel() .. {
        $0.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    private let emptyImage = UIImageView() .. {
        $0.contentMode = .scaleAspectFit
    }

    // MARK: - Aux
    override func configureSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(emptyImage)
        stackView.addArrangedSubview(label)
    }

    override func configureConstraints() {
        stackView.centerInSuperview(usingSafeArea: true)
        emptyImage.height(120)
    }

    func show(
        icon: UIImage,
        message: String
    ) {
        label.text = message
        emptyImage.image = icon
        isHidden = false
    }

    func hide() {
        isHidden = true
    }
}
