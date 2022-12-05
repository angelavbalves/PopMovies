//
//  PMView.swift
//  PopMovies
//
//  Created by Angela Alves on 20/10/22.
//

import Foundation
import UIKit

class PMView: UIView {

    // MARK: Init
    init() {
        super.init(frame: .zero)
        configureSubviews()
        configureConstraints()
        backgroundColor = Theme.currentTheme.color.backgroundColor.rawValue
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureSubviews() {}

    func configureConstraints() {}
}
