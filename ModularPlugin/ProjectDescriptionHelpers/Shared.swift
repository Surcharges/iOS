import Foundation

public enum Shared: Project {
  case Services
  case ServiceProtocols
}

public extension Shared {
  var name: String {
    return String(describing: self)
  }
  
  var path: String {
    return "\(parent.path)/Shared/\(name)"
  }
  
  var parent: Workspace {
    return Surcharges.Surcharges
  }
}
