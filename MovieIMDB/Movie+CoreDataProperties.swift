//
//  Movie+CoreDataProperties.swift
//  MovieIMDB
//
//  Created by Prakhar Garg on 24/09/23.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var rating: Double
    @NSManaged public var toPlaylist: Playlist?

}

extension Movie : Identifiable {

}
