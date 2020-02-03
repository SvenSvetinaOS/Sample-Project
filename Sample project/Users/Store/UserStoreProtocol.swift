//
//  UserStoreProtocol.swift
//  Users
//
//  Created by Sven Svetina on 14/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

import Foundation

/**
 Saves and fetches users to and from a designated database
 Implement this protocol when adding a new user in a feature module
 */

protocol UserStoreProtocol {
    
    // Saves user to database
    func save(userModel: UserModel)
    
    // Fetches user from database
    func fetchUsers(completion: @escaping ([User]) -> Void)
}
