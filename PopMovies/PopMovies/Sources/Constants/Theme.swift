//
//  Theme.swift
//  PopMovies
//
//  Created by Angela Alves on 20/10/22.
//

import Foundation
import UIKit

struct Theme {
    let color: Colors

    struct Colors {
        let backgroundColor: Color
        let textColor: Color
        let cellBackgroundColor: Color
        let viewBackgroundColor: Color
        let tabBarColor: Color
        let itemsNav: Color
        let navColor: Color
        let shadowColor: Color
    }
}

extension Theme {
    static let currentTheme = Theme(
        color: Colors(
            backgroundColor: .init(light: Constants.ColorsApp.beige, dark: Constants.ColorsApp.metalGris),
            textColor: .init(light: .black, dark: .white),
            cellBackgroundColor: .init(light: Constants.ColorsApp.lightBlue, dark: Constants.ColorsApp.gray),
            viewBackgroundColor: .init(light: Constants.ColorsApp.lightGray, dark: Constants.ColorsApp.mediumGray),
            tabBarColor: .init(light: Constants.ColorsApp.brown, dark: .systemBackground),
            itemsNav: .init(light: .black, dark: .white),
            navColor: .init(light: Constants.ColorsApp.brown, dark: .systemBackground),
            shadowColor: .init(light: .black, dark: .black)
        )
    )
}
