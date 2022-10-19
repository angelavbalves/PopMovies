//
//  PMService.swift
//  PopMovies
//
//  Created by Angela Alves on 10/10/22.
//

import Foundation

struct PMService {
    var getMovies: (_ page: Int, _ result: @escaping (Result<MovieResponse, MovieErrorState>) -> Void) -> Void
}

extension PMService {
    static func live(_ apiClient: PopMoviesClientProtocol = PopMoviesClient()) -> Self {
        .init(
            getMovies: { page, result in
                apiClient.makeRequest(
                    endpoint: .movies(page: page),
                    result
                )
        })
    }
}
