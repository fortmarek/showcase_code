//
//  ManagedDecodable.swift
//  Cards
//
//  Created by Marek Fořt on 8/23/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import CoreData


protocol ManagedDecodable {
    static var entityName: String {get}
    var objectID: NSManagedObjectID? {get set}
    func createNewManaged<T: ManagedDecodable>(_ object: T, context: NSManagedObjectContext) -> T?
    func updateManaged(_ managedObject: NSManagedObject, context: NSManagedObjectContext)
    func setValues(_ object: NSManagedObject, context: NSManagedObjectContext)
    static func managedToEntity(_ managedObject: NSManagedObject?) -> ManagedDecodable?
}

extension ManagedDecodable {
    static func query(_ entityName: String, context: NSManagedObjectContext, predicate: NSPredicate?) -> Array<ManagedDecodable> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context)
        fetchRequest.entity = entityDescription
        fetchRequest.predicate = predicate
        
        var finalArray: Array<ManagedDecodable> = []
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results {
                guard let managedObject = result as? NSManagedObject else {return finalArray}
                if let entityObject = Self.managedToEntity(managedObject) {
                    finalArray.append(entityObject)
                }
            }
            return finalArray
        }
        catch {
            fatalError()
        }
        return []
    }
    
    func getManagedObject<T: ManagedDecodable>(_ entity: T?, context: NSManagedObjectContext) -> NSManagedObject? {
        guard let managedEntity = entity else {return nil}
        if let objectId = managedEntity.objectID {
            do {
                let managedObject = try context.existingObject(with: objectId)
                managedEntity.setValues(managedObject, context: context)
                try context.save()
                return managedObject
            }
            catch {
                fatalError()
            }
        }
        else {
            let object = NSEntityDescription.insertNewObject(forEntityName: T.entityName, into: context)
            managedEntity.setValues(object, context: context)
            do {
                try context.save()
                return object
            }
            catch {
                fatalError()
            }
            
        }
    }
    
    
    
    func createNewManaged<T: ManagedDecodable>(_ object: T, context: NSManagedObjectContext) -> T? {
        
        let object = NSEntityDescription.insertNewObject(forEntityName: T.entityName, into: context)
        setValues(object, context: context)
        do {
            try context.save()
        }
        catch {
            fatalError()
        }
        
        var newObject = self
        newObject.objectID = object.objectID
        return newObject as? T
    }
    
    func delete(_ context: NSManagedObjectContext) {
        do {
            guard let objectID = self.objectID else {return}
            let managedObject = try context.existingObject(with: objectID)
            context.delete(managedObject)
            try context.save()
        }
        catch {
            fatalError()
        }
    }
    
    func resetDataForEntity(_ entityName: String, context: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context)
        fetchRequest.entity = entityDescription
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results {
                guard let managedObject = result as? NSManagedObject else {return}
                context.delete(managedObject)
                try context.save()
            }
        }
        catch {
            fatalError()
        }
    }
    
    func updateManaged(_ managedObject: NSManagedObject, context: NSManagedObjectContext) {
        setValues(managedObject, context: context)
        do {
            try context.save()
        }
        catch {
            fatalError()
        }
    }
    
    func getManagedOrderSet<T: ManagedDecodable>(_ entityArray: Array<T>?, context: NSManagedObjectContext) -> NSOrderedSet? {
        guard let managedArray = getManagedArray(entityArray, context: context) else {return nil}
        return NSOrderedSet(array: managedArray)
    }
    
    func getManagedArray<T: ManagedDecodable>(_ entityArray: Array<T>?, context: NSManagedObjectContext) -> [NSManagedObject]? {
        guard let entityArray = entityArray, entityArray.count > 0 else {return nil}
        return entityArray.map{getManagedObject($0, context: context)!}
    }
}
