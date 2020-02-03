//
//  User+CoreDataProperties.swift
//  Users
//
//  Created by Sven Svetina on 08/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

import Foundation
import CoreData


extension User {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    @NSManaged public var userId: Int
    @NSManaged public var name: String
    @NSManaged public var phone: String
    @NSManaged public var website: String
    @NSManaged public var album: NSSet?
    @NSManaged public var post: NSSet?
    
    
    static func createManagedUser1(context: NSManagedObjectContext, from model: UserModel) -> User {
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
        user.name = model.name
        user.userId = model.id
        user.phone = model.phone
        user.website = model.website
        
        do {
            try context.save()
        } catch {
            print ("error saving \(user)")
        }
        
        return user
    }
    
    static func createManagedUser(context: NSManagedObjectContext, user: UserModel) {
        
        var photosByAlbumId = [Int: [Photo]]()
        var albumsByUserId = [Int : [Album]]()
        var commentsByPostId = [Int: [Comment]]()
        var postsByUserId = [Int : [Post]]()
        
        let managedUser = createManagedUser1(context: context, from: user)
        
        for post in user.postModel {
            var postsArray = postsByUserId[post.userId, default: [Post]()]
            postsArray.append(Post.createManagedPost(in: context, from: post))
            postsByUserId[post.id] = postsArray
            
            for comment in post.commentModel {
                    var commentsArray = commentsByPostId[comment.postId, default: [Comment]()]
                    commentsArray.append(Comment.createManagedComment(in: context, from: comment))
                    commentsByPostId[comment.id] = commentsArray
            }
        }
        
        for album in user.albumModel {
                var albumsArray = albumsByUserId[album.id, default: [Album]()]
                albumsArray.append(Album.createManagedAlbum(in: context, from: album))
                albumsByUserId[album.id] = albumsArray
            
            for photo in album.photoModel {
                    var photosArray = photosByAlbumId[photo.albumId, default: [Photo]()]
                    photosArray.append(Photo.createManagedPhoto(in: context, from: photo))
                    photosByAlbumId[photo.id] = photosArray
            }
        }
        do {
            try context.save()
        } catch (let error) {
            print(error)
        }
    }
    
    @objc(addPostObject:)
    @NSManaged public func addToPost(_ value: Post)
    
    @objc(removePostObject:)
    @NSManaged public func removeFromPost(_ value: Post)
    
    @objc(addPost:)
    @NSManaged public func addToPost(_ values: NSSet)
    
    @objc(removePost:)
    @NSManaged public func removeFromPost(_ values: NSSet)
    
    @objc(addAlbumObject:)
    @NSManaged public func addToAlbum(_ value: Album)
    
    @objc(removeAlbumObject:)
    @NSManaged public func removeFromAlbum(_ value: Album)
    
    @objc(addAlbum:)
    @NSManaged public func addToAlbum(_ values: NSSet)
    
    @objc(removeAlbum:)
    @NSManaged public func removeFromAlbum(_ values: NSSet)
}

