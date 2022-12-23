//
//  CoreData.swift
//  PopMovies
//
//  Created by Angela Alves on 10/10/22.
//

import CoreData
import Foundation
import UIKit

final class FavoriteMoviesDataSource: FavoriteMoviesDataSourceProtocol {

    // MARK: - Init
    init(coreDataStack: PopMoviesCoreDataProtocol, managedObjectContext: NSManagedObjectContext) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = managedObjectContext
    }

    // MARK: - Properties
    let coreDataStack: PopMoviesCoreDataProtocol
    let managedObjectContext: NSManagedObjectContext

    // MARK: - Save
    /// Save the movie in the core data
    func save(movie: MovieItem) {
        guard verifyMovieInCoreData(for: movie.id) == false else {
            return
        }

        let newMovie = NSEntityDescription.insertNewObject(forEntityName: coreDataStack.entityName, into: managedObjectContext)
        newMovie.setValue(movie.id, forKey: "id")
        newMovie.setValue(movie.title, forKey: "title")
        newMovie.setValue(movie.overview, forKey: "overview")
        newMovie.setValue(movie.posterPath, forKey: "poster_path")
        newMovie.setValue(movie.releaseDate, forKey: "release_date")

        coreDataStack.saveContext(managedObjectContext)
    }

    func verifyMovieInCoreData(for id: Int) -> Bool {

        let nsRequest = NSFetchRequest<FavoriteMovieItem>(entityName: "FavoriteMovieItem")
        nsRequest.returnsObjectsAsFaults = false

        do {
            let data = try managedObjectContext.fetch(nsRequest)
            let movies = data
            return movies.contains(where: { $0.id == id })

        } catch {
            print("error : \(error)")
            return false
        }
    }

    func removeMovie(for id: Int) {

        let nsRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovieItem")
        nsRequest.returnsObjectsAsFaults = false

        do {
            let data = try managedObjectContext.fetch(nsRequest)

            guard let movies = data as? [FavoriteMovieItem] else { return }

            let movieToBeRemoved = movies.first(where: { $0.id == id })

            if let movieToBeRemoved = movieToBeRemoved {
                managedObjectContext.delete(movieToBeRemoved)
            }
            try managedObjectContext.save()

        } catch {}
    }

    func removeAllFavoriteMovies() {
        let fetchRequet = NSFetchRequest<FavoriteMovieItem>(entityName: coreDataStack.entityName)

        do {
            let fetchedResults = try managedObjectContext.fetch(fetchRequet)
            for movie in fetchedResults {
                managedObjectContext.delete(movie)
            }
            try managedObjectContext.save()
        } catch {}
    }

    func fetchAllMovies() -> [MovieItem] {
        let fetchRequet = NSFetchRequest<FavoriteMovieItem>(entityName: coreDataStack.entityName)

        do {
            let fetchedResults = try coreDataStack.storeContainer.viewContext.fetch(fetchRequet)
            let movies = Movies(movies: fetchedResults.map(MovieItem.init)).movies
            return movies
        } catch {
            debugPrint("Could not fetch \(error.localizedDescription)")
            return []
        }
    }
}
