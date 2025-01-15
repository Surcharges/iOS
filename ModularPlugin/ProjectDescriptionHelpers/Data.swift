import Foundation

public enum DataLayer: Project {
  case DTOs
  case Repositories
  case RepositoryProtocols
  case Networks
}

public extension DataLayer {
  var name: String {
    return String(describing: self)
  }
  
  var path: String {
    return "\(parent.path)/DataLayer/\(name)"
  }
  
  var parent: Workspace {
    return Surcharges.Surcharges
  }
}
