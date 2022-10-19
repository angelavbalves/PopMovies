//
//  MovieErrorState.swift
//  PopMovies
//
//  Created by Angela Alves on 10/10/22.
//

import Foundation

enum MovieErrorState: Swift.Error {
    case clientError
    case serverError
    case redirectError
    case noConnection
    case generic(_ description: String)
}
