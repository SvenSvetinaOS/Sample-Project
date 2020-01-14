//
//  UserFetchRequestProtocol.swift
//  Users
//
//  Created by Sven Svetina on 08/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

import CoreData

protocol UserFetchRequestProtocol {
    
    func userFetchRequest(forEntityname name: String) -> NSFetchRequest<User>
    
}
