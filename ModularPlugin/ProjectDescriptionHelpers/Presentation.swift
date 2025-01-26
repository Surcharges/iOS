import Foundation

public enum PresentationLayer: Project {
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
    case Toast
    case Main
    case PlaceDetail
    case ReportSurcharge
    case SurchargeStatusHelp
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

extension PresentationLayer {
  public enum Routers: Project {
    case RouterProtocols
    case MainRouter
    case PlaceDetailRouter
    case ReportSurchargeRouter
  }
}

public extension PresentationLayer.Routers {
  var name: String {
    return String(describing: self)
  }
  
  var path: String {
    return "\(parent.path)/PresentationLayer/Routers/\(name)"
  }
  
  var parent: Workspace {
    return Surcharges.Surcharges
  }
}
