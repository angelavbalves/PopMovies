//
//  PMLoadingView.swift
//  PopMovies
//
//  Created by Angela Alves on 27/10/22.
//

import Foundation
import TinyConstraints
import UIKit

class PMLoadingView: PMView {

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
    let activeIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - Aux
    override func configureSubviews() {
        backgroundColor = Theme.currentTheme.color.cellColor.rawValue
        addSubview(activeIndicator)
        activeIndicator.centerInSuperview()
    }

    func show() {
        isHidden = false
        activeIndicator.startAnimating()
    }

    func hide() {
        isHidden = true
        activeIndicator.stopAnimating()
    }
}
