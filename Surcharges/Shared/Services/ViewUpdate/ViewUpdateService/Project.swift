import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: Shared.Services.ViewUpdateService)

let target = surcharges.target(
  projects:
    [
      Shared.Services.ViewUpdateServiceProtocol
    ]
)

let project = surcharges.project(targets: [target])
