//
//  Persistable.swift
//  Users
//
//  Created by Sven Svetina on 10/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//
//
//import Foundation
//import CoreData
//
//protocol Persistable: NSFetchRequestResult, DomainConvertibleType {
//    static var entityName: String {get}
//    static func fetchRequest() -> NSFetchRequest<Self>
//}
//
//extension Persistable {
//    static var primaryAttribute: Attribute<String> {
//        return Attribute("uid")
//    }
//}
//
