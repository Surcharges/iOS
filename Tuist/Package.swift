// swift-tools-version: 6.0
@preconcurrency import PackageDescription

#if TUIST
import struct ProjectDescription.PackageSettings

let packageSettings = PackageSettings(
  // Customize the product types for specific package product
  // Default is .staticFramework
  // productTypes: ["Alamofire": .framework]
)
#endif

let package = Package(
  name: "Surcharges",
  dependencies: [
    // Add your own dependencies here:
    // .package(url: "https://github.com/Alamofire/Alamofire", exact: "5.10.2")
    // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
  ]
)
