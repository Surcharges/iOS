import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: Shared.Services.LocationService)

let target = surcharges.target(
  projects:
    [
      Shared.Services.LocationServiceProtocol
    ]
)

let project = surcharges.project(targets: [target])
