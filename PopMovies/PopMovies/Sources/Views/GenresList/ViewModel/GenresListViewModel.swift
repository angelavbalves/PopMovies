//
//  GenresListViewModel.swift
//  PopMovies
//
//  Created by Angela Alves on 21/11/22.
//

import Foundation
import UIKit

class GenresListViewModel {

    // MARK: - Properties
    private let service: PMService

    // MARK: - Init
    init(service: PMService = .live()) {
        self.service = service
    }

    // MARK: - Aux
    func getGenresList(_ completion: @escaping (GenresState) -> Void) {
        service.listGenres { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let genreResponse):
                        completion(.success(genreResponse.genres))
                    case .failure:
                        completion(.error)
                }
            }
        }
    }
}
