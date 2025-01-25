import Foundation

public enum DataSource: Project {
  case EndpointProtocol
  case ProductionEndpoint
  case DevelopmentEndpoint
}

public extension DataSource {
  var name: String {
    return String(describing: self)
  }
  
  var path: String {
    switch self {
    case .EndpointProtocol:
      return "\(parent.path)/DataSource/\(name)"
    default:
      return "\(parent.path)/DataSource/Endpoints/\(name)"
    } 
  }
  
  var parent: Workspace {
    return Surcharges.Surcharges
  }
}
