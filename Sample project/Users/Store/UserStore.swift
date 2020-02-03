//
//  UserRepostory.swift
//  Users
//
//  Created by Sven Svetina on 08/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

import CoreData
import UIKit

class UserStore: UserStoreProtocol {
    var userModels = [UserModel]()
    
    private let coreDataStack: CoreDataStack
    private let networkService = UserService()
    private let reachability = Reachability()
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func save(userModel: UserModel){
        let context = coreDataStack.context(forType: .write)
        
        context.perform {
            User.createManagedUser(context: context, user: userModel)
            do {
                try context.save()
            } catch (let error) {
                print("\(error)")
            }
        }
    }
    
    func fetchUsers (completion: @escaping ([User]) -> Void) {
        let context = coreDataStack.context(forType: .read)
        let userRequest = NSFetchRequest<User>(entityName: "User")
        let postRequest = NSFetchRequest<Post>(entityName: "Post")
        let commentRequest = NSFetchRequest<Comment>(entityName: "Comment")
        let albumRequest = NSFetchRequest<Album>(entityName: "Album")
        let photoRequest = NSFetchRequest<Photo>(entityName: "Photo")
        
        do {
            let users = try context.fetch(userRequest)
            let posts = try context.fetch(postRequest)
            let comments = try context.fetch(commentRequest)
            let albums = try context.fetch(albumRequest)
            let photos = try context.fetch(photoRequest)
            
            completion(users)
        } catch {
            print("fetching users has failed")
        }
    }
}
