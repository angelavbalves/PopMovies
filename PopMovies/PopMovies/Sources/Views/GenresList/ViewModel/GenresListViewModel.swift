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
    private let coordinator: GenresListCoordinator

    // MARK: - Init
    init(
        service: PMService = .live(),
        coordinator: GenresListCoordinator
    ){
        self.service = service
        self.coordinator = coordinator
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

    func routeToList(for id: Int, _ name: String) {
        coordinator.routeToList(for: id, name)
    }
}
