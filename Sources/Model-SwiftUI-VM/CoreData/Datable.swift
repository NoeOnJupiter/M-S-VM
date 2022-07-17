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
    var id: UUID? {get set}
//MARK: - Mapping
    static func map(from object: Object?) -> Self?
    func getObject(from object: Object, isUpdating: Bool) -> Object
//MARK: - Fetching
    static var modelData: ModelData<Self> {get}
}

public extension Datable {
//MARK: - Mapping
    static func latestObject(for id: UUID?) -> Object? {
        guard let viewContext = Configurations.shared.managedObjectContext else {
            fatalError("You should set the ViewContext of the Configurations using Configurations.setObjectContext")
        }
        guard let fetchRequest = Object.fetchRequest() as? NSFetchRequest<Object>, let id = id else {
            return nil
        }
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")
        guard let object = try? viewContext.fetch(fetchRequest).first else {
            return nil
        }
        return object
    }//
//MARK: - Entity
    var updatedObject: Object {
        return self.getObject(from: Self.latestObject(for: self.id) ?? Object(), isUpdating: true)
    }
    var object: Object {
        guard let viewContext = Configurations.shared.managedObjectContext else {
            fatalError("You should set the ViewContext of the Configurations using Configurations.setObjectContext")
        }
        let newObject = self.getObject(from: Object(context: viewContext), isUpdating: false)
        newObject.setValue(nil, forKey: "id")
        return newObject
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
                guard let id = id else {return}
                guard var toUpdate = Self.latestObject(for: id) else {return}
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
            guard let id = id else {return}
            guard let toUpdate = Self.latestObject(for: id) else {return}
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
