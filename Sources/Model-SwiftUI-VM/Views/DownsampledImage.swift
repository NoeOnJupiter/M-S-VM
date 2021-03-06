////
////  File.swift
////  
////
////  Created by Joe Maghzal on 6/15/22.
////
//
//import SwiftUI
//
//public struct DownsampledImage: View {
//    @State public var height: CGFloat?
//    @State public var oldImage: UNImage?
//    @State public var width: CGFloat?
//    @State public var placeHolder: AnyView
//    public let squared: Bool
//    public init(image: UIImage? = nil, data: Data? = nil, height: CGFloat? = nil, width: CGFloat? = nil, squared: Bool = false, @ViewBuilder content: () -> some View = {Text("Error")}) {
//        self.placeHolder = AnyView(content())
//        self.squared = squared
//        self.height = height
//        self.width = width
//        if let data {
//            self.oldImage = UNImage(data: data)
//        }else if let image {
//            self.oldImage = image
//        }
//    }
//    public var body: some View {
//        if let oldImage {
//            if let width, let height, let image = oldImage.downsampledImage(maxWidth: width, maxHeight: height) {
//                Image(unImage: image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .framey(width: image.maxDimensions(width: width, height: height).width, height: image.maxDimensions(width: width, height: height).height, masterWidth: self.width, masterHeight: self.height, master: squared)
//            }else if let width, let image = oldImage.downsampledImage(width: width) {
//                Image(unImage: image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .framey(width: width, height: image.fitHeight(for: width), masterWidth: self.width, masterHeight: self.height, master: squared)
//            }else if let height, let image = oldImage.downsampledImage(height: height) {
//                Image(unImage: image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .framey(width: image.fitWidth(for: height), height: height, masterWidth: self.width, masterHeight: self.height, master: squared)
//            }else {
//                placeHolder
//            }
//        }else {
//            placeHolder
//        }
//    }
//    public func squaredImage() -> DownsampledImage {
//        return DownsampledImage(image: self.oldImage, height: height, width: width, squared: true) {
//            placeHolder
//        }
//    }
//}
