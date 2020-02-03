//
//  UserUseCaseProtocol.swift
//  Users
//
//  Created by Sven Svetina on 09/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

/**
Implement this protocol when adding a new user in a feature module
*/
protocol UserUseCaseProtocol {
    
    // Queries all available users
    func queryUsers(completion: @escaping ([UserModel]) -> Void)
}
