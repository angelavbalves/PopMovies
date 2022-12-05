//
//  PopMoviesViewModel.swift
//  PopMovies
//
//  Created by Angela Alves on 20/10/22.
//

import Foundation
import UIKit

class PopMoviesViewModel {

    var service: PMService
    var currentPage = 1
    weak var coordinator: AppCordinator?

    init(
        service: PMService = .live(),
         coordinator: AppCordinator
    ) {
         self.coordinator = coordinator
        self.service = service
    }

    func getMovies(_ completion: @escaping (State) -> Void) {
        service.getMovies(currentPage) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                    case .success(let movieResponse):
                        let movies = movieResponse.results.map(MovieItem.init)
                        if !movieResponse.results.isEmpty {
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
