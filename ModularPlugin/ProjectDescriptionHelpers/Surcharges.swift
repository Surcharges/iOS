import Foundation

enum Surcharges: Workspace {
  
  case Surcharges
  
  var name: String {
    switch self {
    case .Surcharges:
      return "Surcharges"
    }
  }
  
  var path: String {
    return "Surcharges"
  }
  
}
