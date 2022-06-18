//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

#if canImport(UIKit)
public typealias UNImage = UIImage
#elseif canImport(AppKit)
public typealias UNImage = NSImage
#endif
#if canImport(UIKit)
public typealias UNColor = UIColor
#elseif canImport(AppKit)
public typealias UNColor = NSColor
#endif
#if canImport(UIKit)
public typealias UNView = UIView
#elseif canImport(AppKit)
public typealias UNView = NSView
#endif

public enum ImageQuality: CGFloat {
    case lowest = 0
    case low = 0.25
    case medium = 0.5
    case high = 0.75
    case highest = 1
}

public enum DateInterval {
    case day, week, month, year
}

public enum MediaState: Equatable {
    public var id: Int {
        switch self {
            case .empty:
                return 0
            case .loading:
                return 1
            case .success:
                return 2
            case .failure:
                return 3
        }
    }
    case empty, loading, success(AnyImage), failure(Error)
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
