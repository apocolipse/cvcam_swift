// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "cvcam_swift",
  platforms: [.iOS(.v16), .macOS(.v13)],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .systemLibrary(name: "opencv", pkgConfig: "opencv4"),
    .executableTarget(
      name: "cvcam_swift",
      dependencies: ["opencv"],
      swiftSettings:  [.interoperabilityMode(.Cxx)]),
  ]
)

