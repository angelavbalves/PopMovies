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
        let cellColor: Color
        let viewColor: Color
        let tabBarColor: Color
        let itemsNav: Color
        let navColor: Color
    }
}

extension Theme {
    static let currentTheme = Theme(
        color: Colors(
            backgroundColor: .init(light: Constants.ColorsApp.beige, dark: Constants.ColorsApp.metalGris),
            textColor: .init(light: .black, dark: .white),
            cellColor: .init(light: Constants.ColorsApp.lightBlue, dark: Constants.ColorsApp.gray),
            viewColor: .init(light: Constants.ColorsApp.lightGray, dark: Constants.ColorsApp.mediumGray),
            tabBarColor: .init(light: Constants.ColorsApp.brown, dark: .systemBackground),
            itemsNav: .init(light: .black, dark: .white),
            navColor: .init(light: Constants.ColorsApp.brown, dark: .systemBackground)
        )
    )
}
