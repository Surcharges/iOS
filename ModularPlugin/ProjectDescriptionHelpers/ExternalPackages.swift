import ProjectDescription
import Foundation

public struct ExternalPackages {
  
  public struct DataLayer {
    public static var Alamofire: TargetDependency {
      return .package(product: "Alamofire", type: .runtime)
    }
  }
  
  public struct PresentationLayer {
    public static var Shimmer: TargetDependency {
      return .package(product: "Shimmer", type: .runtime)
    }
  }
  
//  public static var Kingfisher: TargetDependency {
//    get {
//      return TargetDependency.external(name: "Kingfisher")
//    }
//  }
}
