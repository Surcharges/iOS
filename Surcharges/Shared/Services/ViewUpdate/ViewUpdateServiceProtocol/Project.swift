import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: Shared.Services.ViewUpdateServiceProtocol)

let target = surcharges.target(
  projects:
    [
      PresentationLayer.Models
    ]
)

let project = surcharges.project(targets: [target])
