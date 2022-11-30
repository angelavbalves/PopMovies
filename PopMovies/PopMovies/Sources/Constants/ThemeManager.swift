//
//  ThemeManager.swift
//  PopMovies
//
//  Created by Angela Alves on 28/11/22.
//

import Foundation

struct ThemeManager {

    static func addDarkModeObserver(to observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: .darkModeHasChanged, object: nil)
    }
}

extension Notification.Name {
    static let darkModeHasChanged = Notification.Name("darkModeHasChanged")
}
