// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Model-SwiftUI-VM",
    platforms: [
           .iOS(.v13),
           .macOS(.v10_15),
           .watchOS(.v6)
       ],
    products: [
        .library(
            name: "Model-SwiftUI-VM",
            targets: ["Model-SwiftUI-VM"]),
    ],
    dependencies: [
    ],
    targets: [
    
        .target(
            name: "Model-SwiftUI-VM",
            dependencies: []),
        .testTarget(
            name: "Model-SwiftUI-VMTests",
            dependencies: ["Model-SwiftUI-VM"]),
    ]
)
