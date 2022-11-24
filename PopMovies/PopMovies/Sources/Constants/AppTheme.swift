//
//  AppTheme.swift
//  PopMovies
//
//  Created by Angela Alves on 23/11/22.
//

import Foundation
import UIKit

enum AppTheme: Int {
    case dark
    case light
    case device
}

extension AppTheme {
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
            case .dark:
                return .dark
            case .light:
                return .light
            case .device:
                return .unspecified
        }
    }
}
