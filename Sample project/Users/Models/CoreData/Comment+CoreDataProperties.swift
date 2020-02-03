//
//  Comment+CoreDataProperties.swift
//  Users
//
//  Created by Sven Svetina on 22/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

import Foundation
import CoreData


extension Comment {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }
    
    @NSManaged public var postId: Int
    @NSManaged public var id: Int
    @NSManaged public var name: String
    @NSManaged public var email: String
    @NSManaged public var body: String
    @NSManaged public var post: Post
    
    
    class func createManagedComment (in context: NSManagedObjectContext, from model: CommentModel) -> Comment {
        let comment = NSEntityDescription.insertNewObject(forEntityName: "Comment", into: context) as! Comment
        comment.id = model.id
        comment.postId = model.postId
        comment.name = model.name
        comment.email = model.email
        comment.body = model.body
        
        do {
            try context.save()
        } catch {
            print ("error saving")
        }
        
        return comment
    }
}
