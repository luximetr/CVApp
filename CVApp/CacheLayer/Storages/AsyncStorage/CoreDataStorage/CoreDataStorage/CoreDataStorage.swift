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
  
  private func performBackgroundTask(block: @escaping (NSManagedObjectContext) -> Void) {
    persistentContainer.performBackgroundTask(block)
  }
  
  // MARK: - Store objects
  
  func storeObjects(_ tableName: String, objects: [AsyncStoringObject], completion: VoidAction?) {
    performBackgroundTask(block: { [weak self] context in
      guard let strongSelf = self else { return }
      do {
        let objectsIds = objects.map { $0.id }
        let entityMOName = strongSelf.createEntityMOName(tableName: tableName)
        let request = NSFetchRequest<NSManagedObject>(entityName: entityMOName)
        request.predicate = NSPredicate(format: "id in %@", objectsIds)
        let objectsMO = try context.fetch(request)
        objects.forEach { object in
          if let objectMO = strongSelf.getObjectMO(id: object.id, from: objectsMO) {
            strongSelf.fillMOObject(
              objectMO: objectMO, json: object.json, context: context)
          } else {
            strongSelf.createManagedObject(
              entityName: entityMOName, json: object.json, context: context)
          }
        }
        try context.save()
        completion?()
      } catch {
        completion?()
      }
    })
  }
  
  // MARK: - Store object
  
  func storeObject(_ tableName: String, object: AsyncStoringObject, completion: VoidAction?) {
    storeObjects(tableName, objects: [object], completion: completion)
  }
  
  // MARK: - Update object
  
  func updateObject(_ tableName: String, object: AsyncStoringObject, completion: VoidAction?) {
    performBackgroundTask { [weak self] context in
      guard let strongSelf = self else { return }
      do {
        let entityMOName = strongSelf.createEntityMOName(tableName: tableName)
        let request = NSFetchRequest<NSManagedObject>(entityName: entityMOName)
        request.predicate = NSPredicate(format: "id == %@", object.id)
        guard let objectMO = try context.fetch(request).first else { return }
        strongSelf.fillMOObject(objectMO: objectMO, json: object.json, context: context)
        try context.save()
        completion?()
      } catch {
        completion?()
      }
    }
  }
  
  // MARK: - Fetch objects
  
  func fetchObjects(tableName: String) -> [JSON]? {
    let entityMOName = createEntityMOName(tableName: tableName)
    let request = NSFetchRequest<NSManagedObject>(entityName: entityMOName)
    guard let objects = try? context.fetch(request) else { return nil }
    let jsons = objects.compactMap { objectJSONConvertor.toJSON(object: $0) }
    return jsons
  }
  
  // MARK: - Remove all objects
  
  func removeAllObjects(tableName: String) {
    let entityMOName = createEntityMOName(tableName: tableName)
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityMOName)
    let request = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    _ = try? persistentContainer.persistentStoreCoordinator.execute(request, with: context)
  }
  
  // MARK: - Helpers
  
  private func getObjectMO(id: String, from objectsMO: [NSManagedObject]) -> NSManagedObject? {
    return objectsMO.first(where: { getObjectId($0) == id })
  }
  
  private func getObjectId(_ object: NSManagedObject) -> String {
    return object.value(forKey: "id") as? String ?? ""
  }
  
  private func createEntityMOName(tableName: String) -> String {
    return tableName + "MO"
  }
  
  @discardableResult
  private func createManagedObject(entityName: String, json: JSON, context: NSManagedObjectContext) -> NSManagedObject? {
    guard !json.isEmpty else { return nil }
    guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else { return nil }
    let objectMO = NSManagedObject(entity: entityDescription, insertInto: context)
    fillMOObject(objectMO: objectMO, json: json, context: context)
    return objectMO
  }
  
  private func fillToOneRelationship(
      objectMO: NSManagedObject,
      relationship: NSRelationshipDescription,
      relationshipJSON: JSON,
      context: NSManagedObjectContext) {
    guard let relationshipEntityName = relationship.destinationEntity?.name else { return }
    let relationshipName = relationship.name
    if let relationshipEntity = objectMO.value(forKey: relationshipName) as? NSManagedObject {
      fillMOObject(objectMO: relationshipEntity, json: relationshipJSON, context: context)
    } else if let relationshipEntity = createManagedObject(entityName: relationshipEntityName, json: relationshipJSON, context: context) {
      objectMO.setValue(relationshipEntity, forKey: relationshipName)
    }
  }
  
  private func fillMOObject(objectMO: NSManagedObject, json: JSON, context: NSManagedObjectContext) {
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
        fillToOneRelationship(
          objectMO: objectMO,
          relationship: relationship,
          relationshipJSON: relationshipJSON,
          context: context)
      }
    }
  }
}
