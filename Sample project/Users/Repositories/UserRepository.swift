//
//  UserRepository.swift
//  Users
//
//  Created by Sven Svetina on 09/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

import Foundation
import CoreData

class UserRepository: UserRepositoryProtocol {
    var userStore: UserStoreProtocol
    var networkService = UserService()
    
    init(userStore: UserStoreProtocol) {
        self.userStore = userStore
    }
    
    func getUsers(completion: @escaping ([UserModel]) -> Void) {
        userStore.fetchUsers(completion: { managedUsers in
            if managedUsers.isEmpty {
                self.networkService.fetchData(completion: { users in
                    // userStore.store users
                    users.forEach { user in
                        self.userStore.save(userModel: user)
                    }
                    completion(users.map({$0 as UserModel})) // u user model)
                })
            } else {
                completion(managedUsers.map({ user in
                    return UserModel.init(user: user)
                }))
            }
        })
    }
}
