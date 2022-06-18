//
//  File.swift
//  
//
//  Created by Joe Maghzal on 6/17/22.
//

import SwiftUI

@available(iOS 16.0, *)
public struct Media<Medium: Mediable>: View {
    public var height: CGFloat?
    @State public var mediable: Medium?
    public var width: CGFloat?
    public var placeHolder: AnyView
    public let squared: Bool
    public init(_ mediable: Medium?, height: CGFloat? = nil, width: CGFloat? = nil, squared: Bool = false, @ViewBuilder content: () -> some View = {Text("Error")}) {
        self._mediable = State(wrappedValue: mediable)
        self.height = height
        self.width = width
        self.placeHolder = AnyView(content())
        self.squared = squared
    }
    public var body: some View {
        VStack {
            switch mediable?.mediaState {
                case .failure(let error):
                    Text(error.localizedDescription)
                case .loading:
                    ProgressView()
                case .success(let anyImage):
                    image(for: anyImage)
                default:
                    placeHolder
            }
        }.onChange(of: mediable?.pickerItem) { pickerItem in
            Task {
                guard let pickerItem else {
                    mediable?.mediaState = .empty
                    return
                }
                mediable?.mediaState = .loading
                do {
                    let result = try await pickerItem.loadTransferable(type: Image.self)
                    mediable?.mediaState = .success(AnyImage(result))
                }catch {
                    mediable?.mediaState = .failure(error)
                }
            }
        }
    }
//MARK: - Functions
    private func image(for anyImage: AnyImage?) -> some View {
        Group {
            if let oldImage = anyImage?.unImage {
                if let width, let height, let image = oldImage.downsampledImage(maxWidth: width, maxHeight: height) {
                    Image(unImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .framey(width: image.maxDimensions(width: width, height: height).width, height: image.maxDimensions(width: width, height: height).height, masterWidth: self.width, masterHeight: self.height, master: squared)
                }else if let width, let image = oldImage.downsampledImage(width: width) {
                    Image(unImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .framey(width: width, height: image.fitHeight(for: width), masterWidth: self.width, masterHeight: self.height, master: squared)
                }else if let height, let image = oldImage.downsampledImage(height: height) {
                    Image(unImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .framey(width: image.fitWidth(for: height), height: height, masterWidth: self.width, masterHeight: self.height, master: squared)
                }else {
                    placeHolder
                }
            }else {
                placeHolder
            }
        }
    }
    public func squaredImage() -> Media {
        return Media(mediable, height: height, width: width, squared: true) {
            placeHolder
        }
    }
}
