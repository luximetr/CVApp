//
//  CoreDataStorage.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 14/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStorage: AsyncStorage {
  
  // MARK: - Properties
  
  private let storageName: String
  private let storeURL: URL?
  
  // MARK: - Life cycle
  
  init(storageName: String, storeURL: URL?) {
    self.storageName = storageName
    self.storeURL = storeURL
  }
  
  // MARK: - Persistence container
  
  lazy var persistentContainer: NSPersistentContainer = {
      let model = createManagedObjectModel()
      let container = NSPersistentContainer(name: storageName, managedObjectModel: model)
      if let storeURL = storeURL {
          let storeDescription = NSPersistentStoreDescription(url: storeURL)
          container.persistentStoreDescriptions = [storeDescription]
      }
      container.loadPersistentStores(completionHandler: { _, error in
          if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()
  
  private func createManagedObjectModel() -> NSManagedObjectModel {
      let bundle = Bundle(for: type(of: self))
      guard let modelURL = bundle.url(forResource: storageName, withExtension: "momd"),
          let model = NSManagedObjectModel(contentsOf: modelURL) else {
          return NSManagedObjectModel()
      }
      return model
  }
  
  // MARK: - Context
  
  private var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  // MARK: - Perform background task
  
  func performBackgroundTask(block: @escaping (NSManagedObjectContext) -> Void) {
      persistentContainer.performBackgroundTask(block)
  }
  
  func storeObject<T>(_ object: T, completion: @escaping () -> Void) {
    performBackgroundTask { context in
      do {
//        let entityName = ""
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        try context.save()
      } catch {
        completion()
      }
    }
  }
  
  func fetchObject<T>(id: String) ->T? {
    return nil
  }
}
