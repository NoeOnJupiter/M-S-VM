//
//  BaseView.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

public struct BaseView: View {
//MARK: - Properties
    @Environment(\.editMode) public var editMode
    @Environment(\.presentationMode) public var presentationMode
    @Environment(\.colorScheme) public var colorScheme
    @StateObject public var viewModel: BaseViewModel
    public let content: AnyView
    public var isBackgroundHidden: Bool
#if canImport(AppKit)
    public var size: Bool
#endif
    public var gesture: (() -> Void)?
//MARK: - Initializers
    init(_ viewModel: some BaseViewModel, @ViewBuilder content: () -> AnyView) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.content = content()
        self.isBackgroundHidden = false
#if canImport(AppKit)
        self.size = false
    #endif
    }
}
