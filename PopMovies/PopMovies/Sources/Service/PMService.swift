//
//  PMService.swift
//  PopMovies
//
//  Created by Angela Alves on 10/10/22.
//

import Foundation

struct PMService {
    var getMovies: (_ page: Int, _ result: @escaping (Result<MovieResponse, ErrorState>) -> Void) -> Void
    var similarMovies: (_ id: Int, _ page: Int, _ result: @escaping (Result<MovieResponse, ErrorState>) -> Void) -> Void
    var searchMovies: (_ page: Int, _ query: String, _ result: @escaping (Result<MovieResponse, ErrorState>) -> Void) -> Void
    var listGenres: (_ completion: @escaping (Result<GenresResponse, ErrorState>) -> Void) -> Void
    var listMoviesByGenre: (_ page: Int, _ genre: Int, _ completion: @escaping (Result<MovieResponse, ErrorState>) -> Void) -> Void
}

extension PMService {
    static func live(_ apiClient: PopMoviesClientProtocol = PopMoviesClient()) -> Self {
        .init(
            getMovies: { page, result in
                apiClient.makeRequest(
                    endpoint: .movies(page: page),
                    result
                )
            },
            similarMovies: { id, page, result in
                apiClient.makeRequest(
                    endpoint: .similarMovies(
                        id: id,
                        page: page
                    ),
                    result
                )
            },
            searchMovies: { page, query, result in
                apiClient.makeRequest(
                    endpoint: .searchMovies(
                        page: page,
                        query: query
                    ),
                    result
                )
            },
            listGenres: { result in
                apiClient.makeRequest(
                    endpoint: .listGenres,
                    result
                )
            },
            listMoviesByGenre: { page, genre, result in
                apiClient.makeRequest(
                    endpoint: .discoverMoviesByGenres(
                        page: page,
                        genre: genre
                    ),
                    result
                )
            }
        )
    }
}
