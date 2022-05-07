//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

extension BaseView {
    func backgroundHidden() -> BaseView {
        var baseView = self
        baseView.isBackgroundHidden = true
        return baseView
    }
#if canImport(AppKit)
    func framey(width: CGFloat? = nil, height: CGFloat? = nil) -> BaseView<Content> {
        var baseView = self
        baseView.size = !(width == nil && height == nil)
        if let width = width {
            viewModel.width = width
        }
        if let height = height {
            viewModel.height = height
        }
        return baseView
    }
#endif
}
