//
//  DomainConvertibleType.swift
//  Users
//
//  Created by Sven Svetina on 10/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

//import Foundation
//import CoreData
//
//protocol DomainConvertibleType {
//    associatedtype DomainType
//
//    func asDomain() -> DomainType
//}
//
//
//
//protocol CoreDataRepresentable {
//    associatedtype CoreDataType: Persistable
//    
//    var uid: String {get}
//    
//    func update(entity: CoreDataType)
//}
//
//extension CoreDataRepresentable {
//    func sync(in context: NSManagedObjectContext) -> CoreDataType {
//        return context.fetch(entity: entity) .sync(entity: self, update: update)
//    }
//}
