//
//  PMNavigationController.swift
//  PopMovies
//
//  Created by Angela Alves on 25/10/22.
//

import Foundation
import UIKit

class PMNavigationController: UINavigationController {

    init(rootViewController: PMViewController) {
        super.init(rootViewController: rootViewController)
        configureAppearance()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func configureAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = Theme.currentTheme.color.tabBarColor.rawValue

        navigationBar.prefersLargeTitles = true
        navigationBar.tintColor = Theme.currentTheme.color.itemsNav.rawValue

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }

}
