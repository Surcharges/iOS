import Foundation

public protocol Workspace: Sendable {
  var name: String { get }
  var path: String { get }
}
