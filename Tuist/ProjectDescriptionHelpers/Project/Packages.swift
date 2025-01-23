import Foundation
import ProjectDescription

public struct Packages {
  public static var Alamofire: Package {
    return .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .exact("5.10.2"))
  }
  
  public static var Shimmer: Package {
    return .remote(url: "https://github.com/markiv/SwiftUI-Shimmer", requirement: .exact("1.5.1"))
  }
  
  public static var Confetti: Package {
    return .remote(url: "https://github.com/simibac/ConfettiSwiftUI", requirement: .exact("2.0.2"))
  }

  public static var ToastUI: Package {
    return .remote(url: "https://github.com/quanshousio/ToastUI", requirement: .exact("4.0.0"))
  }
  
  public static var all: [Package] {
    return [
      Alamofire,
      Shimmer,
      Confetti,
      ToastUI,
    ]
  }
}
