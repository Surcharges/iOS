import Foundation

public protocol Project: Workspace {
  var parent: Workspace { get }
}

public extension Project {
  
  var path: String {
    return "\(parent.path)/\(name)"
  }
  
  var bundleId: String {
    return path.replacingOccurrences(of: "/", with: ".")
  }
}
