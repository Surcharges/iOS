import ProjectDescription
import Foundation

public struct ExternalPackages {
  public static var Alamofire: TargetDependency {
    return .package(product: "Alamofire", type: .runtime)
  }
  
//  public static var Kingfisher: TargetDependency {
//    get {
//      return TargetDependency.external(name: "Kingfisher")
//    }
//  }
}
