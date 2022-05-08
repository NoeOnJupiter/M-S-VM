//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI
import Combine

public class BaseViewModel: NSObject, ObservableObject {
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
    @Published public var error: BaseError? {
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
}

public protocol BaseError {
    var disappearanceRange: Double {get set}
}

public enum Loading: Equatable {
    case loading, stopped
    case progress(Double)
}
