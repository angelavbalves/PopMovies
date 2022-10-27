//
//  CollectionReusableViews.swift
//  PopMovies
//
//  Created by Angela Alves on 26/10/22.
//

import Foundation
import UIKit
import TinyConstraints

class HeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "HeaderCollectionReusableView"

    private let label = UILabel() .. {
        $0.text = "Similar Movies"
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 22.0)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.centerInSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

