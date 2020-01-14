//
//  UserRepository.swift
//  Users
//
//  Created by Sven Svetina on 09/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

import Foundation
import CoreData


//class Repository<T: CoreDataRepresentable>: RepositoryProtocol where T == T.CoreDataType.DomainType {
//    
//    private let context: NSManagedObjectContext
//    
//    init(context: NSManagedObjectContext) {
//        self.context = context
//    }
    
//    func query(with predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
//        let request = T.CoreDataType.fetchRequest()
//        request.predicate = predicate
//        request.sortDescriptors = sortDescriptors
//        return context.fetch(request)
//
//    }
    
//    func save(entity: T)  {
//        do {
//            entity.sync(in: context)
//        try context.save()
//        } catch (let error) {
//            print(error)
//        }
//    }
    
//    func delete(entity: T) {
//        entity.sync(in: context).
//    }
    
    
    
//}
