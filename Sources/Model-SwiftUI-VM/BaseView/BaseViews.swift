//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI
import Introspect

public extension BaseView {
    var body: some View {
        GeometryReader { proxy in
            if let contentBody = Configurations.shared.body {
                contentBody(self)
            }else {

               Text("You should set the content of the Configurations using Configurations.makeBody")
                    .onAppear {
                        fatalError("You should set the content of the Configurations using Configurations.makeBody")
                    }
            }
        }.onAppear(perform: viewModel.validate)
        .onDisappear(perform: viewModel.invalidate)
        .introspectTabBarController { tabBarController in
            viewModel.tabBarController = tabBarController
        }.onTask {
            if #available(iOS 15.0, macOS 12.0, watchOS 8.0, *) {
                await viewModel.validateTask()
            }
        }.bindColors(colorScheme)
#if canImport(AppKit)
        .bind(proxy: proxy, viewModel: viewModel, bindable: !size)
#endif
    }
}
