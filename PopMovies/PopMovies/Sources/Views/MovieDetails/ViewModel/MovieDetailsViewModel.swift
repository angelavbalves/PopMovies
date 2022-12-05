//
//  MovieDetailsViewModel.swift
//  PopMovies
//
//  Created by Angela Alves on 24/10/22.
//

import Foundation
import UIKit

class MovieDetailsViewModel {

    weak var coordinator: AppCordinator?

    init(coordinator: AppCordinator) {
        self.coordinator = coordinator
    }

}
