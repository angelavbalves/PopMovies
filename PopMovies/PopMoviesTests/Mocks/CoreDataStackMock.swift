//
//  MoviesCoreDataStack.swift
//  PopMoviesTests
//
//  Created by Angela Alves on 13/10/22.
//

import CoreData
@testable import PopMovies

class CoreDataStackMock: PopMoviesCoreDataProtocol {
    var entityName = "FavoriteMovieItem"

    func saveContext(_ context: NSManagedObjectContext) {
        print("Save context called")
    }

    var modelName: String = "FavoriteMovie"

    lazy var model: NSManagedObjectModel = {
       guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            return NSManagedObjectModel()
        }
        return NSManagedObjectModel(contentsOf: modelURL) ?? NSManagedObjectModel()
    }()

    lazy var mainContext: NSManagedObjectContext = {
        self.storeContainer.viewContext
    }()

    lazy var storeContainer: NSPersistentContainer = {
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType

        let container = NSPersistentContainer(
            name: entityName,
            managedObjectModel: model
        )

        container.persistentStoreDescriptions = [persistentStoreDescription]

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}
