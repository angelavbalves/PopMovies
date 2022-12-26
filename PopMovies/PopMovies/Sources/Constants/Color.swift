//
//  Color.swift
//  PopMovies
//
//  Created by Angela Alves on 20/10/22.
//

import Foundation
import UIKit

struct Color {
    let rawValue: UIColor

    init(light: UIColor, dark: UIColor) {
        self.rawValue = UIColor {
            $0.userInterfaceStyle == .light ? light : dark
        }
    }
}
