//
//  Array+Ext.swift
//  PopMovies
//
//  Created by Angela Alves on 03/01/23.
//

import Foundation

extension Array where Element == MovieItem {
    func uniquesById() -> [MovieItem] {
        let uniquesMovies: [MovieItem] = reduce([]) { currentMovies, nextMovie in
            if currentMovies.contains(nextMovie) {
                return currentMovies
            }
            return currentMovies + [nextMovie]
        }

        return uniquesMovies
    }
}
