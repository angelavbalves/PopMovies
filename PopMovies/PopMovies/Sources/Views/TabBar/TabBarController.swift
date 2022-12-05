//
//  TabBarController.swift
//  PopMovies
//
//  Created by Angela Alves on 20/10/22.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {

    func configureTabBar() {
        tabBar.backgroundColor = Theme.currentTheme.color.tabBarColor.rawValue
        tabBar.tintColor = .white
        tabBar.isTranslucent = false
        tabBar.barTintColor = Theme.currentTheme.color.tabBarColor.rawValue

        guard let items = tabBar.items else { return }

        items[0].title = "Home"
        items[0].image = UIImage(systemName: "house.fill")!

        items[1].title = "Favorites"
        items[1].image = UIImage(systemName: "star.square")!

        items[2].title = "Genres"
        items[2].image = UIImage(systemName: "list.and.film")!
    }
}
