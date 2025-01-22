import Foundation

public enum Shared: Project {
  
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

extension Shared {
  public enum Services: Project {
    case LocationService
    case LocationServiceProtocol
    case AppStatusService
    case AppStatusServiceProtocol
  }
}

public extension Shared.Services {
  var name: String {
    return String(describing: self)
  }
  
  var path: String {
    switch self {
    case .LocationService, .LocationServiceProtocol:
      return "\(parent.path)/Shared/Services/Location/\(name)"
    case .AppStatusService, .AppStatusServiceProtocol:
      return "\(parent.path)/Shared/Services/AppStatus/\(name)"
    }
  }
  
  var parent: Workspace {
    return Surcharges.Surcharges
  }
}
