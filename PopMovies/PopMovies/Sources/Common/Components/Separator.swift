//
//  Separator.swift
//  PopMovies
//
//  Created by Angela Alves on 26/10/22.
//

import Foundation
import TinyConstraints

class Separator: PMView {

    override init() {
        super.init()
        setAppearance()
    }

    func setAppearance() {
        height(2)
        backgroundColor = .black
    }
}
