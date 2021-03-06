//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

public extension View {
    var colors: Configurations {
        return Configurations.shared
    }
    func bind(_ viewModel: some BaseViewModel, colorScheme: ColorScheme) -> BaseView {
        return BaseView(viewModel) {
            AnyView(
                self
                    .bindColors(colorScheme)
            )
        }
    }
    func bindColors(_ colorScheme: ColorScheme) -> some View {
        Configurations.shared.colorScheme = colorScheme
        if #available(iOS 14.0, macOS 11, watchOS 7, *) {
            return AnyView(
                self
                .onChange(of: colorScheme) { newValue in
                    Configurations.shared.colorScheme = newValue
                })
        }
        return AnyView(self)
    }
#if canImport(AppKit)
    func bind(proxy: GeometryProxy, viewModel: some BaseViewModel, bindable: Bool) -> some View {
        if #available(iOS 14.0, macOS 11, watchOS 7, *) {
            return AnyView(
                self
                    .onChange(of: proxy.size) { newValue in
                        guard bindable else {return}
                        viewModel.width = newValue.width
                        viewModel.height = newValue.height
                    }.onAppear {
                        guard bindable else {return}
                        viewModel.width = proxy.size.width
                        viewModel.height = proxy.size.height
                    }
            )
        }else {
            return AnyView(self)
        }
    }
#endif
}
