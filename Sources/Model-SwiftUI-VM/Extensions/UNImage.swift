//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import Foundation

extension UNImage {
    func asData(_ quality: ImageQuality) -> Data? {
#if canImport(UIKit)
        return jpegData(compressionQuality: quality.rawValue)
#elseif canImport(AppKit)
        return self.tiffRepresentation
#endif
    }
}
