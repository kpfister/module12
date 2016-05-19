//
//  Stack.swift
//  CoreDataMiniProject
//
//  Created by Jordan Nelson on 2/13/16.
//  Copyright © 2016 Jordan Nelson. All rights reserved.
//

import Foundation

import CoreData

class Stack {
    
    static let sharedStack = Stack() // This is a singleton
    
    // TEACHING NOTE: - lazy variables do not get initialized until the first time they are called
    lazy var managedObjectContext: NSManagedObjectContext = Stack.setUpMainContext() // Bank analogy: This is me. I have the money. ( money being my objects)
    
    static func setUpMainContext() -> NSManagedObjectContext { // Bank analogy: This is teling where the bank is and where the tellar is
        
        // TEACHING NOTE: - merging all models from bundle (if there are more than one)
        let bundle = NSBundle.mainBundle()
        guard let model = NSManagedObjectModel.mergedModelFromBundles([bundle])
            else { fatalError("model not found") }
        
        // TEACHING NOTE: - initializing persistent store coordinator using merged model
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model) // Bank analogy: This is the tellar
        try! persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil,
            URL: storeURL(), options: nil) // This tells the Tellar where the Vault is
        
        //           ^ file path on disk
        
        // TEACHING NOTE: - initializing managed object context and assigning its persistent store coordinator
        let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType) // Context is me at the bank
        context.persistentStoreCoordinator = persistentStoreCoordinator // Who is the tellar?
        return context // return tellar name
    }
    
    static func storeURL () -> NSURL? {
        // TEACHING NOTE: - creating url for persistent store
        let documentsDirectory: NSURL? = try? NSFileManager.defaultManager().URLForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: true)
        
        return documentsDirectory?.URLByAppendingPathComponent("db.sqlite")
    }
}