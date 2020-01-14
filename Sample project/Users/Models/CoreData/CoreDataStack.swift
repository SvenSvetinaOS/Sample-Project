//
//  CoreDataStack.swift
//  Users
//
//  Created by Sven Svetina on 08/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStack {

    private let bundle = Bundle.main
    private let dataModelName = "Users"

    private let readContext: NSManagedObjectContext
    private let writeContext: NSManagedObjectContext
    let persistentStoreCoordinator: NSPersistentStoreCoordinator

    init() throws {
        guard
            let modelURL = bundle.url(forResource: dataModelName, withExtension: "momd"),
            let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        else {
            throw CoreDataError.modelCouldNotBeCreated(modelName: dataModelName)
        }

        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)

        readContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        readContext.persistentStoreCoordinator = persistentStoreCoordinator
        readContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy

        writeContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        writeContext.persistentStoreCoordinator = persistentStoreCoordinator
        writeContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        try! migrateStore()
    }

    private func migrateStore() throws {
        guard let url = FileManager.default.urls(for: .documentDirectory,
                                                 in: .userDomainMask).last else {
                                                    fatalError()
        }
        let storePath = "\(dataModelName).sqlite"
        let storeUrl = url.appendingPathComponent(storePath)
        
        let migrationOptions = [
            NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true
        ]

        #if DEBUG
        print("DB url: \(storeUrl)")
        #endif

        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                    configurationName: nil,
                                                    at: storeUrl,
                                                    options: migrationOptions)
        } catch {
            throw CoreDataError.storeCouldNotBeCreated(storeUrl: storePath)
        }
    }

    func context(forType type: ContextType) -> NSManagedObjectContext {
        return type == .read ? readContext : writeContext
    }

}
