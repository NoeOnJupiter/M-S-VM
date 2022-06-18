//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

public extension View {
    #if canImport(UIKit)
    var uiImage: UIImage {
        let controller = UIHostingController(rootView: self)
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        let image = controller.view.uiImage
        controller.view.removeFromSuperview()
        return image
    }
    #endif
    func foreground<Content: View>(_ view: Content) -> some View {
        self.overlay(view).mask(self)
    }
    func foreground<Content: View>(@ViewBuilder view: @escaping () -> Content) -> some View {
        self.overlay(view()).mask(self)
    }
    func onTask(id: (any Equatable)? = nil, priority: _Concurrency.TaskPriority? = nil, _ task: @Sendable @escaping () async -> Void) -> AnyView {
        if #available(iOS 15.0, macOS 12.0, watchOS 8.0, *) {
            if let id, let priority {
                return AnyView(
                    self
                        .task(id: id, priority: priority, task)
                )
            }else if let id {
                return AnyView(
                    self
                        .task(id: id, task)
                )
            }else if let priority {
                return AnyView(
                    self
                        .task(priority: priority, task)
                )
            }
            return AnyView(
                self
                    .task(task)
            )
        }
        return AnyView(self)
    }
    func tapGesture(completion: (() -> Void)? = nil) -> some View {
        guard let completion = completion else {
            return AnyView(self)
        }
        return AnyView(
            self
                .onTapGesture {
                    completion()
                }
        )
    }
}

extension View {
    func framey(width: CGFloat, height: CGFloat, masterWidth: CGFloat? = nil, masterHeight: CGFloat? = nil, master: Bool) -> some View {
        if master {
            return self
                .frame(width: masterWidth ?? width, height: masterHeight ?? height)
        }
        return self
            .frame(width: width, height: height)
    }
}
