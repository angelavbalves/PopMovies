//
//  ApiEndpoints.swift
//  PopMovies
//
//  Created by Angela Alves on 10/10/22.
//

import Foundation

enum ApiEndpoints: Equatable {
    case movies(page: Int)
    case similarMovies(id: Int, page: Int)
    case searchMovies(page: Int, query: String)
    case listGenres
    case discoverMoviesByGenres(page: Int, genre: Int)
}

extension ApiEndpoints: Endpoint {
    var host: String {
        return "api.themoviedb.org"
    }

    var path: String {
        switch self {
            case .similarMovies(let id, _):
                return "/3/movie/\(id)/similar"
            case .searchMovies:
                return "/3/search/movie"
            case .listGenres:
                return "/3/genre/movie/list"
            case .discoverMoviesByGenres(_, _):
                return "/3/discover/movie"
            default:
                return "/3/movie/popular"
        }
    }

    var method: String {
        return "get"
    }

    var query: [URLQueryItem] {
        switch self {
            case .movies(let page):
                return [
                    .init(name: "api_key", value: "f66bae459e0caf58012f1645bfb5e772"),
                    .init(name: "page", value: "\(page)")
                ]
            case .similarMovies(_, let page):
                return [
                    .init(name: "api_key", value: "f66bae459e0caf58012f1645bfb5e772"),
                    .init(name: "language", value: "en-US"),
                    .init(name: "page", value: "\(page)")
                ]
            case .searchMovies(let page, let query):
                return [
                    .init(name: "api_key", value: "f66bae459e0caf58012f1645bfb5e772"),
                    .init(name: "language", value: "en-US"),
                    .init(name: "query", value: query),
                    .init(name: "page", value: "\(page)"),
                    .init(name: "include_adult", value: "false")
                ]
            case .listGenres:
                return [
                    .init(name: "api_key", value: "f66bae459e0caf58012f1645bfb5e772"),
                    .init(name: "language", value: "en-US")
                ]
            case .discoverMoviesByGenres(let page, let genre):
                return [
                    .init(name: "api_key", value: "f66bae459e0caf58012f1645bfb5e772"),
                    .init(name: "language", value: "en-US"),
                    .init(name: "sort_by", value: "popularity.desc"),
                    .init(name: "include_adult", value: "false"),
                    .init(name: "page", value: "\(page)"),
                    .init(name: "with_genres", value: "\(genre)"),
                    .init(name: "with_watch_monetization_types", value: "flatrate")
                ]
        }
    }
}
