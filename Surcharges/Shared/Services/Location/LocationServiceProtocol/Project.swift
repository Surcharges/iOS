import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: Shared.Services.LocationServiceProtocol)

let target = surcharges.target(
  projects:
    [
      
    ]
)

let project = surcharges.project(targets: [target])
