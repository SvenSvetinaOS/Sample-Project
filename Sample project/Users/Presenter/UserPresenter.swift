//
//  UserPresenter.swift
//  Users
//
//  Created by Sven Svetina on 09/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

import CoreData
import UIKit

class UserPresenter {
    
    private let coreDataStack: CoreDataStack
    var userUseCase: UserUseCaseProtocol!
    var reachability = Reachability()
    var userEntity = String(describing: "User")
    
    init(userUseCase: UserUseCaseProtocol, coreDataStack: CoreDataStack) {
        self.userUseCase = userUseCase
        self.coreDataStack = coreDataStack
    }
    
    func query(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> User {
        let context = coreDataStack.context(forType: .read)
        let request = NSFetchRequest<User>(entityName: userEntity)
        var user: User!
        
        if let predicate = predicate {
            request.predicate = predicate
        }
        request.sortDescriptors = sortDescriptors
        
        do {
            let result = try context.fetch(request)
            for data in result as [User] {
                user = data
            }
        } catch {
            print("failed")
        }
        return user
    }
    
    func queryAllUsers(completion: @escaping ([UserModel]) -> Void) {
        var userModels = [UserModel]()
        userUseCase.queryUsers(completion: { users in
            userModels = users
            completion(userModels)
        })
    }
    
    func save(userModel: UserModel) {
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
    
    func isEmpty(entity: String) -> Bool {
        let context = coreDataStack.context(forType: .read)
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            let count = try context.count(for: request)
            return count == 0
        } catch {
            return true
        }
    }
    
    func users(completion: @escaping ([UserModel]) -> Void) {
        userUseCase.queryUsers(completion: completion)
    }
}

