//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

extension BaseView {
    var body: some View {
        GeometryReader { proxy in
            if let contentBody = Configurations.shared.body {
                contentBody(self)
                    .bindColors(colorScheme)
#if canImport(AppKit)
                    .bind(proxy: proxy, viewModel: viewModel, bindable: !size)
#endif
            }else {
                EmptyView()
                    .onAppear {
                        fatalError("You should set the content of the Configurations using Configurations.makeBody")
                    }
            }
        }
    }
}
