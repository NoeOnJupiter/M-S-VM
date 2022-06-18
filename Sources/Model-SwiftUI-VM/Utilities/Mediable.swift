//
//  File.swift
//  
//
//  Created by Joe Maghzal on 6/17/22.
//

import SwiftUI
import PhotosUI

@available(iOS 16.0, *)
public protocol Mediable {
    var anyImage: AnyImage {get set}
    var mediaState: MediaState {get set}
    var pickerItem: PhotosPickerItem? {get set}
}
