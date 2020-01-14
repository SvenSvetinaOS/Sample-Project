//
//  CoreDataError.swift
//  Users
//
//  Created by Sven Svetina on 08/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

enum CoreDataError: Error {
    case modelCouldNotBeCreated(modelName: String)
    case storeURLCouldNotBeCreated
    case storeCouldNotBeCreated(storeUrl: String)
}

