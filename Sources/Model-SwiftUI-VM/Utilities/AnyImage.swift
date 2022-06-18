//
//  File.swift
//  
//
//  Created by Joe Maghzal on 6/17/22.
//

import SwiftUI

public struct AnyImage: Equatable {
//MARK: - Properties
    public static var empty = AnyImage()
    public var data: Data?
    public var image: Image?
    public var unImage: UNImage?
//MARK: - Private Initializers
    private init() {

    }
}

//MARK: - Public Initializers
public extension AnyImage {
    init(_ data: Data?) {
        guard let data else {return}
        self.data = data
        self.unImage = UNImage(data: data)
        if let unImage {
            self.image = Image(unImage: unImage)
        }else {
            self.image = nil
        }
    }
    init(_ image: Image?) {
        guard let image else {return}
        self.image = image
        self.unImage = image.unImage
        self.data = unImage?.asData(.high)
    }
    init(_ unImage: UNImage?) {
        guard let unImage else {return}
        self.unImage = unImage
        self.image = Image(unImage: unImage)
        self.data = unImage.asData(.high)
    }
}
