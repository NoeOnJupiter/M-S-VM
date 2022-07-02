//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

public extension BaseView {
    func onTap(gesture: @escaping () -> Void) -> BaseView {
        var baseView = self
        baseView.gesture = gesture
        return baseView
    }
    func backgroundHidden() -> BaseView {
        var baseView = self
        baseView.isBackgroundHidden = true
        return baseView
    }
#if canImport(UIKit)
    func tabBarHidden() -> BaseView {
        var baseView = self
        baseView.viewModel.isTabBarHidden = true
        baseView.isBackgroundHidden = true
        return baseView
    }
#endif
#if canImport(AppKit)
    public func framey(width: CGFloat? = nil, height: CGFloat? = nil) -> BaseView<Content> {
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
