//
//  FavoriteMovieItem+CoreDataProperties.swift
//  PopMovies
//
//  Created by Angela Alves on 26/12/22.
//
//

import Foundation
import CoreData


extension FavoriteMovieItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovieItem> {
        return NSFetchRequest<FavoriteMovieItem>(entityName: "FavoriteMovieItem")
    }

    @NSManaged public var id: Int64
    @NSManaged public var overview: String?
    @NSManaged public var poster_path: String?
    @NSManaged public var release_date: String?
    @NSManaged public var title: String?

}

extension FavoriteMovieItem : Identifiable {

}
