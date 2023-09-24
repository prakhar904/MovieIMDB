//
//  Playlist+CoreDataProperties.swift
//  MovieIMDB
//
//  Created by Prakhar Garg on 24/09/23.
//
//

import Foundation
import CoreData


extension Playlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Playlist> {
        return NSFetchRequest<Playlist>(entityName: "Playlist")
    }

    @NSManaged public var name: String?
    @NSManaged public var toMovie: NSSet?

}

// MARK: Generated accessors for toMovie
extension Playlist {

    @objc(addToMovieObject:)
    @NSManaged public func addToToMovie(_ value: Movie)

    @objc(removeToMovieObject:)
    @NSManaged public func removeFromToMovie(_ value: Movie)

    @objc(addToMovie:)
    @NSManaged public func addToToMovie(_ values: NSSet)

    @objc(removeToMovie:)
    @NSManaged public func removeFromToMovie(_ values: NSSet)

}

extension Playlist : Identifiable {

}
