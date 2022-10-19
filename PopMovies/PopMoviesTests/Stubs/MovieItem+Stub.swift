//
//  MovieItem+Stub.swift
//  PopMoviesTests
//
//  Created by Angela Alves on 17/10/22.
//

import Foundation
@testable import PopMovies

extension MovieItem {
    static func stub(
        id: Int = 0,
        title: String = "",
        overview: String = "",
        posterPath: String? = nil,
        releaseDate: String? = nil
    ) -> MovieItem {
        .init(
            from: .init(
                id: id,
                title: title,
                overview: overview,
                posterPath: posterPath,
                releaseDate: releaseDate
            )
        )
    }
}
