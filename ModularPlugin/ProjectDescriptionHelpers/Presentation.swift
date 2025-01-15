import Foundation

public enum PresentationLayer: Project {
  case Applications
  case ViewModels
  case ViewModelProtocols
  case Models
}

public extension PresentationLayer {
  var name: String {
    return String(describing: self)
  }
  
  var path: String {
    return "\(parent.path)/PresentationLayer/\(name)"
  }
  
  var parent: Workspace {
    return Surcharges.Surcharges
  }
}

extension PresentationLayer {
  public enum UIs: Project {
    case CommonUI
    case UIExtensions
    case Resources
    case Main
  }
}

public extension PresentationLayer.UIs {
  var name: String {
    return String(describing: self)
  }
  
  var path: String {
    return "\(parent.path)/PresentationLayer/UIs/\(name)"
  }
  
  var parent: Workspace {
    return Surcharges.Surcharges
  }
}
