//
//  PMErrorView.swift
//  PopMovies
//
//  Created by Angela Alves on 07/12/22.
//

import Foundation
import UIKit
import TinyConstraints

class PMErrorView: PMView {

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

    private let errorImage = UIImageView() .. {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "error")
    }

    let label = UILabel() .. {
        $0.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    // MARK: - Aux
    override func configureSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(errorImage)
        stackView.addArrangedSubview(label)
    }

    override func configureConstraints() {
        stackView.centerInSuperview(usingSafeArea: true)
        errorImage.height(80)
    }
    
    func show(errorState: ErrorState) {
        isHidden = false
        switch errorState {
            case .clientError(let message):
                label.text = message
            case .serverError(let message):
                label.text = message
            case .redirectError(let message):
                label.text = message
            case .noConnection(let message):
                label.text = message
            case .generic(let message):
                label.text = message
        }
    }

    func hide() {
        isHidden = true
    }
}
