//
//  BaseView.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

struct BaseView: View {
//MARK: - Properties
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: BaseViewModel
    var bodyContent: AnyView?
    let content: AnyView
    var isBackgroundHidden: Bool
#if canImport(AppKit)
    var size: Bool
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
