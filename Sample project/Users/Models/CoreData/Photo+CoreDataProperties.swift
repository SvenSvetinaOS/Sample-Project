//
//  Photo+CoreDataProperties.swift
//  Users
//
//  Created by Sven Svetina on 22/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

import Foundation
import CoreData


extension Photo {
    
    static let photoName = String(describing: Photo.self)
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: photoName)
    }
    
    @NSManaged public var albumId: Int
    @NSManaged public var id: Int
    @NSManaged public var title: String
    @NSManaged public var url: String
    @NSManaged public var thumbnailUrl: String
    @NSManaged public var album: Album
    
    class func createManagedPhoto (in context: NSManagedObjectContext, from model: PhotoModel) -> Photo {
        let photo = NSEntityDescription.insertNewObject(forEntityName: photoName, into: context) as! Photo
        
        photo.id = model.id
        photo.albumId = model.albumId
        photo.title = model.title
        photo.url = model.url
        photo.thumbnailUrl = model.thumbnailUrl
        
        do {
            try context.save()
        } catch {
            print ("error saving \(photo)")
        }
        
        return photo
        
    }
}
