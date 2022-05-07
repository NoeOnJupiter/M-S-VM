//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI
import Combine

class BaseViewModel: NSObject, ObservableObject {
//MARK: - Properties
#if canImport(AppKit)
    @Published var width = CGFloat(1000) {
        didSet {
            Size.shared.size.width = width
        }
    }
    @Published var height = CGFloat(1000) {
        didSet {
            Size.shared.size.height = height
        }
    }
#endif
    @Published var error: BaseError? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + (error?.disappearanceRange ?? 0)) {
                self.error = nil
            }
        }
    }
    @Published var loading = Loading.stopped
    var cancellables = Set<AnyCancellable>()
//MARK: - Initializers
    required override init() {
    }
}

protocol BaseError {
    var disappearanceRange: Double {get set}
}

enum Loading: Equatable {
    case loading, stopped
    case progress(Double)
}
