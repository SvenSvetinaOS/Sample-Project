//
//  UserRepositoryProtocol.swift
//  Users
//
//  Created by Sven Svetina on 09/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

import CoreData


protocol UserRepositoryProtocol {

    //Queries all users from the database. If the database is empty, fetches the user data from the API
    func getUsers(completion: @escaping ([UserModel]) -> Void)
}
