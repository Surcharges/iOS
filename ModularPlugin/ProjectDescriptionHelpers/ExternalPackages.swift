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
    
    public static var Confetti: TargetDependency {
      return .package(product: "ConfettiSwiftUI", type: .runtime)

    public static var ToastUI: TargetDependency {
      return .package(product: "ToastUI", type: .runtime)
    }

  }
  
}
