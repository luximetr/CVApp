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
    container.loadPersistentStores(completionHandler: { storeDescription, error in
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
        let entityMOName = tableName + "MO"
        let request = NSFetchRequest<NSManagedObject>(entityName: entityMOName)
        let allObjects = try context.fetch(request)
        allObjects.forEach { context.delete($0) }
        
        _ = self?.createManagedObject(entityName: entityMOName, json: json, context: context)
        try context.save()
        completion()
      } catch {
        completion()
      }
    }
  }
  
  private func createManagedObject(entityName: String, json: JSON, context: NSManagedObjectContext) -> NSManagedObject? {
    guard !json.isEmpty else { return nil }
    guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else { return nil }
    let objectMO = NSManagedObject(entity: entityDescription, insertInto: context)
    
    let attributesNames = objectMO.entity.attributesByName.map { $0.key }
    let relationshipsNames = objectMO.entity.relationshipsByName.map { $0.key }
    
    attributesNames.forEach { attributeName in
      guard let value = json[attributeName] else { return }
      objectMO.setValue(value, forKey: attributeName)
    }
    
    relationshipsNames.forEach { relationshipName in
      guard let relationship = objectMO.entity.relationshipsByName[relationshipName] else { return }
      guard let relationshipEntityName = relationship.destinationEntity?.name else { return }
      
      if relationship.isToMany {
        
        guard let relationshipJSONs = json[relationshipName] as? [JSON] else { return }
        let relationshipEntities = relationshipJSONs.compactMap { createManagedObject(entityName: relationshipEntityName, json: $0, context: context) }
        objectMO.setValue(NSSet(array: relationshipEntities), forKey: relationshipName)
        
      } else {
        
        guard let relationshipJSON = json[relationshipName] as? JSON else { return }
        guard let relationshipEntity = createManagedObject(entityName: relationshipEntityName, json: relationshipJSON, context: context) else { return }
        objectMO.setValue(relationshipEntity, forKey: relationshipName)
        
      }
    }
    return objectMO
  }
  
  func fetchObjects(tableName: String) -> [JSON]? {
    let classMOName = tableName + "MO"
    let request = NSFetchRequest<NSManagedObject>(entityName: classMOName)
    guard let objects = try? context.fetch(request) else { return nil }
    let jsons = objects.compactMap { objectJSONConvertor.toJSON(object: $0) }
    return jsons
  }
}
