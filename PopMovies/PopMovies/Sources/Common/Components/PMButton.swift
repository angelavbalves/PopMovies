//
//  PMButton.swift
//  PopMovies
//
//  Created by Angela Alves on 09/11/22.
//

import Foundation
import TinyConstraints
import UIKit

class PMButton: UIButton {

    private let propertyAnimator = UIViewPropertyAnimator(duration: 0.2, curve: .easeOut)

    override var isHighlighted: Bool {
        didSet {
            setBackgroundColor()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        self.setContentHuggingPriority(.required, for: .horizontal)
        self.tintColor = .black
        self.setTitle("Add to favorites", for: .normal)
        self.setTitleColor(.black, for: .normal)
        let image = UIImage(systemName: "heart")
        self.setImage(image, for: .normal)
        self.backgroundColor = Constants.ColorsApp.lightBlue
        self.height(48)
        self.layer.cornerRadius = 4.0
        self.clipsToBounds = true
    }

    func setBackgroundColor() {
        if isHighlighted {
            propertyAnimator.stopAnimation(true)
            backgroundColor = Constants.ColorsApp.darkBlue
            return
        }
        propertyAnimator.addAnimations {
            self.backgroundColor = Constants.ColorsApp.lightBlue
        }
        propertyAnimator.startAnimation()
    }
}
