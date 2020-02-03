//
//  Post+CoreDataProperties.swift
//  Users
//
//  Created by Sven Svetina on 22/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

import Foundation
import CoreData


extension Post {
    
    static var postName = String(describing: Post.self)
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: postName)
    }
    
    @NSManaged public var user: User
    @NSManaged public var userId: Int
    @NSManaged public var id: Int
    @NSManaged public var title: String
    @NSManaged public var body: String
    @NSManaged public var comment: [Comment]
    
    
    static func createManagedPost(in context: NSManagedObjectContext, from model: PostModel) -> Post {
        let post = NSEntityDescription.insertNewObject(forEntityName: postName, into: context) as! Post
        
        post.userId = model.userId
        post.id = model.id
        post.title = model.title
        post.body = model.body
        
        do {
            try context.save()
        } catch {
            print ("error saving post")
        }
        
        
        return post
    }
    @objc(addPostObject:)
     @NSManaged public func addToComment(_ value: Comment)
     
     @objc(removePostObject:)
     @NSManaged public func removeFromComment(_ value: Comment)
     
     @objc(addPost:)
     @NSManaged public func addToComment(_ values: NSSet)
     
     @objc(removePost:)
     @NSManaged public func removeFromComment(_ values: NSSet)
}


