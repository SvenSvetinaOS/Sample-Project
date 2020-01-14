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
    
    init(userStore: UserStoreProtocol) {
        self.userStore = userStore
    }
    
    var user: User {
        return userStore.fetchUser()
    }
}
