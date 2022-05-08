//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

public extension View {
    var width: CGFloat {
#if canImport(UIKit)
        return UIScreen.main.bounds.width
#elseif canImport(AppKit)
        return Size.shared.size.width
#endif
    }
    var height: CGFloat {
#if canImport(UIKit)
        return UIScreen.main.bounds.height
#elseif canImport(AppKit)
        return Size.shared.size.height
#endif
    }
    func leading() -> some View {
        return HStack {
            self
            Spacer()
        }
    }
    func trailing() -> some View {
        return HStack {
            Spacer()
            self
        }
    }
    func top() -> some View {
        return VStack {
            self
            Spacer()
        }
    }
    func centerV() -> some View {
        return VStack {
            Spacer()
            self
            Spacer()
        }
    }
    func centerH() -> some View {
        return HStack {
            Spacer()
            self
            Spacer()
        }
    }
    func bottom() -> some View {
        return VStack {
            Spacer()
            self
        }
    }
}

#if canImport(AppKit)
public class Size {
    static var shared = Size()
    var size = (NSScreen.main?.visibleFrame ?? .zero).size
}
#endif
