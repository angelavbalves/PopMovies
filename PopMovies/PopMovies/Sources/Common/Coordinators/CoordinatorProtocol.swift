//
//  CoordinatorProtocol.swift
//  PopMovies
//
//  Created by Angela Alves on 24/10/22.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    var rootViewController: PMNavigationController? { get }
    func start()
}
