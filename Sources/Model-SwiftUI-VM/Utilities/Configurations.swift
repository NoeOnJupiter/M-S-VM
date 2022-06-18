//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import Foundation
import SwiftUI
import CoreData

public final class Configurations {
    public static var shared = Configurations()
    public static var scheme: ColorScheme {
        return Configurations.shared.colorScheme
    }
    var colorScheme = ColorScheme.light
    public var body: ((BaseView) -> AnyView)?
    var managedObjectContext: NSManagedObjectContext?
//MARK: - Functions
    public static func makeBody(@ViewBuilder body: @escaping (BaseView) -> some View) {
        Configurations.shared.body = { base in
            AnyView(body(base))
        }
    }
    public static func setObjectContext(_ managedObjectContext: NSManagedObjectContext) {
        Configurations.shared.managedObjectContext = managedObjectContext
    }
}
