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
  
  // MARK: - Dependencies
  
  private let objectJSONConvertor = NSManagedObjectJSONConvertor()
  
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
  
  func storeObject(_ tableName: String, json: JSON, completion: @escaping () -> Void) {
    performBackgroundTask { [weak self] context in
      do {
        let classMOName = tableName + "MO"
        
        let request = NSFetchRequest<NSManagedObject>(entityName: classMOName)
        let allObjects = try context.fetch(request)
        allObjects.forEach { context.delete($0) }
        
        guard let entityDesciption = NSEntityDescription.entity(forEntityName: classMOName, in: context) else { return }
        let entity = NSManagedObject(entity: entityDesciption, insertInto: context)
        
        for (_, (key, value)) in json.enumerated() {
          if let valueJSON = value as? JSON {
            let fieldClassName = key.capitalizingFirstLetter() + "MO"
            guard let entityDesc = NSEntityDescription.entity(forEntityName: fieldClassName, in: context) else { return }
            let fieldEntity = NSManagedObject(entity: entityDesc, insertInto: context)
            for (_, (key1, value1)) in valueJSON.enumerated() {
              fieldEntity.setValue(value1, forKey: key1)
            }
            entity.setValue(fieldEntity, forKey: key)
          } else {
            entity.setValue(value, forKey: key)
          }
        }
//        self?.objectJSONConvertor.fillObject(entity, json: json)
        
        try context.save()
        completion()
      } catch {
        completion()
      }
    }
  }
  
  func fetchObjects(tableName: String) -> [JSON]? {
    let classMOName = tableName + "MO"
    let request = NSFetchRequest<NSManagedObject>(entityName: classMOName)
    guard let objects = try? context.fetch(request) else { return nil }
    let jsons = objects.compactMap { objectJSONConvertor.toJSON(object: $0) }
    return jsons
  }
}
