import Foundation
import ProjectDescription

public struct Packages {
  public static var Alamofire: Package {
    return .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .exact("5.10.2"))
  }
  
  public static var all: [Package] {
    return [
      Alamofire
    ]
  }
}
