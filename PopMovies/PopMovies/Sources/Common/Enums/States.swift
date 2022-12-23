//
//  State.swift
//  PopMovies
//
//  Created by Angela Alves on 21/10/22.
//

import Foundation

enum PopMoviesState {
    case success([MovieItem])
    case error(ErrorState)
}

enum GenresState {
    case success([Genre])
    case error(ErrorState)
}
