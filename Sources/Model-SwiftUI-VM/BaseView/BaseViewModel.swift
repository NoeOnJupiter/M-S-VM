//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI
import Combine

open class BaseViewModel: NSObject, ObservableObject {
//MARK: - Properties
#if canImport(AppKit)
    @Published public var width = CGFloat(1000) {
        didSet {
            Size.shared.size.width = width
        }
    }
    @Published public var height = CGFloat(1000) {
        didSet {
            Size.shared.size.height = height
        }
    }
#endif
    @Published public var error: (any BaseError)? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + (error?.disappearanceRange ?? 0)) {
                self.error = nil
            }
        }
    }
    @Published public var loading = Loading.stopped
    public var cancellables = Set<AnyCancellable>()
//MARK: - Initializers
    required override public init() {
    }
//MARK: - Functions
    open func invalidate() {
    }
    @available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
    open func validateTask() async {
    }
    open func validate() {
    }
}

public protocol BaseError {
    var disappearanceRange: Double {get set}
}

public enum Loading: Equatable {
    case loading(String? = nil)
    case stopped
    case progress(Double)
}

public struct BaseAlert {
    var title: String
    var description: String
    struct Action {
        var title: String
        var action: (() -> Void)?
    }
}
