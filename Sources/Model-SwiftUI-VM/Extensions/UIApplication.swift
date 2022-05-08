//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

#if canImport(UIKit)
public extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows.filter({$0.isKeyWindow}).first?.endEditing(force)
    }
}
#endif
