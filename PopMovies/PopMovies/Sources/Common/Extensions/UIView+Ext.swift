//
//  UIView+Ext.swift
//  PopMovies
//
//  Created by Angela Alves on 02/01/23.
//

import Foundation
import UIKit

extension UIView {
    var isSmallScreen: Bool {
        let width = UIScreen.main.bounds.width
        return width <= 375
    }
}
