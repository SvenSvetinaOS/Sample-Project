//
//  User+Extension.swift
//  Users
//
//  Created by Sven Svetina on 07/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

import CoreData

extension User {
    
    func fromModel(model: UserModel) {
        name = model.name
    }
}
