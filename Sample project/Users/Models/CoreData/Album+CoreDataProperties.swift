//
//  Album+CoreDataProperties.swift
//  Users
//
//  Created by Sven Svetina on 22/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

import Foundation
import CoreData


extension Album {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Album> {
        return NSFetchRequest<Album>(entityName: "Album")
    }
    
    @NSManaged public var id: Int
    @NSManaged public var title: String
    @NSManaged public var photo: [Photo]
    @NSManaged public var user: User
    
    
    class func createManagedAlbum (in context: NSManagedObjectContext, from model: AlbumModel) -> Album {
        let album = NSEntityDescription.insertNewObject(forEntityName: "Album", into: context) as! Album
        album.id = model.id
        album.title = model.title
        
        do {
            try context.save()
        } catch {
            print ("error saving \(album)")
        }
        return album
    }
    
    @objc(addPostObject:)
     @NSManaged public func addToPhoto(_ value: Photo)
     
     @objc(removePostObject:)
     @NSManaged public func removeFromPhoto(_ value: Photo)
     
     @objc(addPost:)
     @NSManaged public func addToPhoto(_ values: NSSet)
     
     @objc(removePost:)
     @NSManaged public func removeFromPhoto(_ values: NSSet)
}
