//
//  File.swift
//  
//
//  Created by Joe Maghzal on 7/17/22.
//

import Foundation
import CoreData

public extension Datable where Self: Iterable {
//    static func map(from object: Object?) -> Self? {
//        guard let properties = try? allProperties() else {
//            return nil
//        }
//    }
    func getObject(from object: Object, isUpdating: Bool) -> Object {
        guard let properties = try? allProperties() else {
            return object
        }
        properties.forEach { property in
            let value = property.value
            let objectType = object.value(forKey: property.key)
            if property.key == "oid" {
                let newValue = value as? UUID ?? UUID()
                object.setValue(newValue, forKey: property.key)
            }else if let datableValue = value as? (any Datable) {
                if datableValue.oid == nil || oid == nil {
                    object.setValue(datableValue.object, forKey: property.key)
                }else {
                    object.setValue(datableValue.updatedObject, forKey: property.key)
                }
            }else if let datableValue = value as? Array<(any Datable)> {
                let set = NSSet(array: datableValue.map { subValue in
                    if subValue.oid == nil || oid == nil{
                       return subValue.object
                    }
                    return subValue.updatedObject
                })
                object.setValue(set, forKey: property.key)
            }else {
                object.setValue(value, forKey: property.key)
            }
        }
        return object
    }
}
