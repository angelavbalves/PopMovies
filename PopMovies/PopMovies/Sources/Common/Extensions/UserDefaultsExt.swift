//
//  UserDefaultsExt.swift
//  PopMovies
//
//  Created by Angela Alves on 23/11/22.
//

import Foundation

extension UserDefaults {
    var appTheme: AppTheme {
        get {
            register(defaults: [#function: AppTheme.device.rawValue])
            return AppTheme(rawValue: integer(forKey: #function)) ?? .device
        }
        set {
            set(newValue.rawValue, forKey: #function)
        }
    }
}
