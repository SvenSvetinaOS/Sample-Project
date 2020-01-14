//
//  UserStoreProtocol.swift
//  Users
//
//  Created by Sven Svetina on 14/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

import Foundation

protocol UserStoreProtocol {
    
    func query(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> User
    func save(userModel: UserModel) -> User
    func fetchUser() -> User
}
