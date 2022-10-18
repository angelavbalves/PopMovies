//
//  PopMoviesCoreDataProtocol.swift
//  PopMovies
//
//  Created by Angela Alves on 13/10/22.
//

import CoreData
import Foundation

protocol PopMoviesCoreDataProtocol {
    var modelName: String { get }
    var entityName: String { get }
    var model: NSManagedObjectModel { get }
    var mainContext: NSManagedObjectContext { get }
    var storeContainer: NSPersistentContainer { get }
    func saveContext(_ context: NSManagedObjectContext)
}
