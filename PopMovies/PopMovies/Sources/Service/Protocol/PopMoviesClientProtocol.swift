//
//  PopMoviesClientProtocol.swift
//  PopMovies
//
//  Created by Angela Alves on 19/10/22.
//

import Foundation

protocol PopMoviesClientProtocol {
    func makeRequest<T: Decodable>(endpoint: ApiEndpoints, _ completion: @escaping (Result<T, ErrorState>) -> Void)
}
