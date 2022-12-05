//
//  MovieDetailsViewModel.swift
//  PopMovies
//
//  Created by Angela Alves on 24/10/22.
//

import Foundation
import UIKit

class MovieDetailsViewModel {

    let service: PMService
    weak var coordinator: AppCordinator?
    var currentPage = 1

    init(
        service: PMService = .live(),
        coordinator: AppCordinator)
    {
        self.service = service
        self.coordinator = coordinator
    }

    func getSimilarMovies(_ id: Int, _ completion: @escaping (State) -> Void) {
        service.similarMovies(id, currentPage) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                    case .success(let movieSimilarResponse):
                        let movies = movieSimilarResponse.results.map(MovieItem.init)
                        if !movieSimilarResponse.results.isEmpty {
                            self?.currentPage += 1
                        }
                        completion(.success(movies))
                    case .failure:
                        completion(.error)
                }
            }

        }
    }
}
