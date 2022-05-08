//
//  BaseView.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

public struct BaseView: View {
//MARK: - Properties
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject public var viewModel: BaseViewModel
    public let content: AnyView
    public var isBackgroundHidden: Bool
#if canImport(AppKit)
    public var size: Bool
#endif
//MARK: - Initializers
    init(_ viewModel: BaseViewModel, @ViewBuilder content: () -> AnyView) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self.content = content()
        self.isBackgroundHidden = false
#if canImport(AppKit)
        self.size = false
    #endif
    }
}
