//
//  PopMoviesCoreDataStack.swift
//  PopMovies
//
//  Created by Angela Alves on 13/10/22.
//

import Foundation
import CoreData

open class PopMoviesCoreDataStack: PopMoviesCoreDataProtocol {

    var modelName = "FavoriteMovie"
    var entityName = "FavoriteMovieItem"

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
        let container = NSPersistentContainer(name: entityName, managedObjectModel: model)

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        return container
    }()

    public func saveContext(_ context: NSManagedObjectContext) {
        if context != mainContext {
            saveDerivedContext(context)
            return
        }
        context.perform {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    public func saveDerivedContext(_ context: NSManagedObjectContext) {
        context.perform {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.saveContext(self.mainContext)
    }

}
