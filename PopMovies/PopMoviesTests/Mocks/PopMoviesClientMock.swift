//
//  PopMoviesClientMock.swift
//  PopMoviesTests
//
//  Created by Angela Alves on 18/10/22.
//

import Foundation
@testable import PopMovies

class PopMoviesClientMock: PopMoviesClientProtocol {

    var mockFile: URL?

    func makeRequest<T: Decodable>(endpoint: ApiEndpoints, _ completion: @escaping (Result<T, MovieErrorState>) -> Void) {
        guard let jsonUrl = mockFile else {
            completion(.failure(.generic("Failed to build JSON URL")))
            return
        }

        guard
            let data = try? Data(contentsOf: jsonUrl),
            let responseMock: T = try? data.decodeFromApi()
        else {
            completion(.failure(.generic("Failed to find ResponseMock")))
            return
        }

        completion(.success(responseMock))
    }
}
