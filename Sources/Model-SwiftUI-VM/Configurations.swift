//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import Foundation
import SwiftUI
import CoreData

public class Configurations {
    init(_ colorScheme: ColorScheme) {
        self.colorScheme = colorScheme
    }
    public static var shared = Configurations(.light)
    public var colorScheme: ColorScheme
    public var body: ((BaseView) -> AnyView) = { base in
        AnyView(Text(""))
    }
    public var managedObjectContext: NSManagedObjectContext?
//MARK: - Functions
    public static func makeBody<Content: View>(@ViewBuilder body: @escaping (BaseView) -> Content) {
        Configurations.shared.body = { base in
            AnyView(body(base))
        }
    }
    public static func setObjectContext(_ managedObjectContext: NSManagedObjectContext) {
        Configurations.shared.managedObjectContext = managedObjectContext
    }
}
