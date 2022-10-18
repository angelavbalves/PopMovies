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
        poster_path: String? = nil,
        release_date: String? = nil
    ) -> MovieItem {
        .init(
            from: .init(
                id: id,
                title: title,
                overview: overview,
                poster_path: poster_path,
                release_date: release_date
            )
        )
    }
}
