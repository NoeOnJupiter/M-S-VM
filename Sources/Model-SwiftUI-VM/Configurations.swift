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
    static var shared = Configurations(.light)
    var colorScheme: ColorScheme
    var body: ((BaseView) -> AnyView)?
    var managedObjectContext: NSManagedObjectContext?
//MARK: - Functions
    static func makeBody<Content: View>(@ViewBuilder body: @escaping (BaseView) -> Content) {
        Configurations.shared.body = { base in
            AnyView(body(base))
        }
    }
    static func setObjectContext(_ managedObjectContext: NSManagedObjectContext) {
        Configurations.shared.managedObjectContext = managedObjectContext
    }
}
