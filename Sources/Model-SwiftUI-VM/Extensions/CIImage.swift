//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

public extension CIImage {
#if canImport(AppKit)
    var nsImage: NSImage {
        let rep = NSCIImageRep(ciImage: self)
        let nsImage = NSImage(size: rep.size)
        nsImage.addRepresentation(rep)
        return nsImage
    }
#endif
    var unImage: UNImage {
#if canImport(UIKit)
        return UIImage(ciImage: self)
#elseif canImport(AppKit)
        return self.nsImage
#endif
    }
}
