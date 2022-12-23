//
//  PMNavigationController.swift
//  PopMovies
//
//  Created by Angela Alves on 25/10/22.
//

import Foundation
import UIKit

class PMNavigationController: UINavigationController {

    // MARK: - Init
    init(rootViewController: PMViewController) {
        super.init(rootViewController: rootViewController)
        configureAppearance()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Aux
    func configureAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = Theme.currentTheme.color.tabBarColor.rawValue

        navigationBar.tintColor = Theme.currentTheme.color.itemsNav.rawValue

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }

}
