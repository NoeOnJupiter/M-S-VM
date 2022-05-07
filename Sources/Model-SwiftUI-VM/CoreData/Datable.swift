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
//MARK: - Mapping
    static func map(from object: Object) -> Self
    func map(from object: Object) -> Self
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
    func map(from object: Object) -> Self {
        return Self.map(from: object)
    }
//MARK: - Writing
    func save() {
        guard let viewContext = Configurations.shared.managedObjectContext else {
            fatalError("You should set the ViewContext of the Configurations using Configurations.setObjectContext")
        }
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
            _ = object
            do {
                try viewContext.save()
            }catch {
                print(String(describing: error))
            }
        }
    }
    func delete() {
        do {
            _ = object
            guard let viewContext = Configurations.shared.managedObjectContext else {
                fatalError("You should set the ViewContext of the Configurations using Configurations.setObjectContext")
            }
            viewContext.delete(object)
            try viewContext.save()
        }catch {
            print(String(describing: error))
        }
    }
}

extension Array {
    func model<T: Datable>() -> [T] {
        return self.map({T.map(from: $0 as! T.Object)})
    }
}
