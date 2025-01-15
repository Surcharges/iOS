import Foundation

public enum Builder: Project {
  case Factories
  case FactoryProtocols
}

public extension Builder {
  var name: String {
    return String(describing: self)
  }
  
  var path: String {
    return "\(parent.path)/Builder/\(name)"
  }
  
  var parent: Workspace {
    return Surcharges.Surcharges
  }
}
