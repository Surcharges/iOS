import Foundation

public enum DomainLayer: Project {
  case UseCases
  case UseCaseProtocols
  case Entities
}

public extension DomainLayer {
  var name: String {
    return String(describing: self)
  }
  
  var path: String {
    return "\(parent.path)/DomainLayer/\(name)"
  }
  
  var parent: Workspace {
    return Surcharges.Surcharges
  }
}
