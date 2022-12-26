//
//  ErrorState.swift
//  PopMovies
//
//  Created by Angela Alves on 10/10/22.
//

import Foundation

enum ErrorState: Swift.Error {
    case clientError(_ description: String)
    case serverError(_ description: String)
    case redirectError(_ description: String)
    case noConnection(_ description: String)
    case generic(_ description: String)
}
