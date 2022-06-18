//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import Foundation
import CoreData

public protocol Datable {
    associatedtype Object: NSManagedObject
    var oID: UUID? {get set}
//MARK: - Mapping
    static func map(from object: Object?) -> Self?
    func map(from object: Object?) -> Self?
    func getObject(from object: Object, isUpdating: Bool) -> Object
    func updateObject() -> Object
    static func getObject(for oID: UUID?) -> Object?
    static func model(for oID: UUID?) -> Self?
//MARK: - Entity
    var object: Object {get}
//MARK: - Fetching
    static var modelData: ModelData<Self> {get}
//MARK: - Writing
    func save()
    func update()
    func delete()
}

public extension Datable {
//MARK: - Mapping
    func map(from object: Object?) -> Self? {
        return Self.map(from: object)
    }
    static func getObject(for oID: UUID?) -> Object? {
        guard let viewContext = Configurations.shared.managedObjectContext else {
            fatalError("You should set the ViewContext of the Configurations using Configurations.setObjectContext")
        }
        guard let fetchRequest = Object.fetchRequest() as? NSFetchRequest<Object>, let oID = oID else {
            return nil
        }
        fetchRequest.predicate = NSPredicate(format: "oID = %@", "\(oID)")
        guard let object = try? viewContext.fetch(fetchRequest).first else {
            return nil
        }
        return object
    }
    static func model(for oID: UUID?) -> Self? {
        guard let viewContext = Configurations.shared.managedObjectContext else {
            fatalError("You should set the ViewContext of the Configurations using Configurations.setObjectContext")
        }
        guard let fetchRequest = Object.fetchRequest() as? NSFetchRequest<Object>, let oID = oID else {
            return nil
        }
        fetchRequest.predicate = NSPredicate(format: "oID = %@", "\(oID)")
        guard let object = try? viewContext.fetch(fetchRequest).first else {
            return nil
        }
        return Self.map(from: object)
    }
//MARK: - Entity
    var object: Object {
        var newDatable = self
        newDatable.oID = nil
        guard let viewContext = Configurations.shared.managedObjectContext else {
            fatalError("You should set the ViewContext of the Configurations using Configurations.setObjectContext")
        }
        let newObject = Object(context: viewContext)
        return newDatable.getObject(from: newObject, isUpdating: false)
    }
    func updateObject() -> Object {
        return self.getObject(from: Self.getObject(for: self.oID) ?? Object(), isUpdating: true)
    }
//MARK: - Writing
    func save() {
        guard let viewContext = Configurations.shared.managedObjectContext else {
            fatalError("You should set the ViewContext of the Configurations using Configurations.setObjectContext")
        }
        _ = object
        do {
            try viewContext.save()
        }catch {
            print(String(describing: error))
        }
    }
    func update() {
        guard let viewContext = Configurations.shared.managedObjectContext else {
            fatalError("You should set the ViewContext of the Configurations using Configurations.setObjectContext")
        }
        viewContext.perform {
            do {
                guard let oID = oID else {return}
                guard var toUpdate = Self.getObject(for: oID) else {return}
                toUpdate = getObject(from: toUpdate, isUpdating: true)
                try viewContext.save()
            }catch {
                print(String(describing: error))
            }
        }
    }
    func delete() {
        guard let viewContext = Configurations.shared.managedObjectContext else {
            fatalError("You should set the ViewContext of the Configurations using Configurations.setObjectContext")
        }
        do {
            guard let oID = oID else {return}
            guard let toUpdate = Self.getObject(for: oID) else {return}
            viewContext.delete(toUpdate)
            try viewContext.save()
        }catch {
            print(String(describing: error))
        }
    }
}

public extension Array {
    func model<T: Datable>() -> [T] {
        return self.compactMap({T.map(from: $0 as? T.Object)})
    }
}
