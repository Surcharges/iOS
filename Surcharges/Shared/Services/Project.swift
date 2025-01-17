import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: Shared.Services)

let target = surcharges.target(
  projects:
    [
      Shared.ServiceProtocols
    ]
)

let project = surcharges.project(targets: [target])
