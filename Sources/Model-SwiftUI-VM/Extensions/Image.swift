//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

public extension Image {
    func asData(_ quality: ImageQuality) -> Data? {
        return self.unImage.asData(quality)
    }
    init(data: Data?, fallback: Image = Image(systemName: "camera")) {
        self.init("")
        if let data = data, let image = UNImage(data: data) {
            self.init(unImage: image)
        }
    }
    init(url: URL, fallback: Image = Image(systemName: "camera")) {
        if let data = try? Data(contentsOf: url), let image = UNImage(data: data) {
            self.init(unImage: image)
        }else {
            self = fallback
        }
    }
    init(unImage: UNImage) {
#if canImport(UIKit)
        self.init(uiImage: unImage)
#elseif canImport(AppKit)
        self.init(nsImage: unImage)
#endif
    }
}
