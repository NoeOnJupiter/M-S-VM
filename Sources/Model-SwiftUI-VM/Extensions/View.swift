//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

extension View {
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
    func foreground<Content: View>(_ view: Content) -> some View {
        self.overlay(view).mask(self)
    }
    func foreground<Content: View>(@ViewBuilder view: @escaping () -> Content) -> some View {
        self.overlay(view()).mask(self)
    }
}
