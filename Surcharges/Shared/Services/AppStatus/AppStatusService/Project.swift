import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: Shared.Services.AppStatusService)

let target = surcharges.target(
  projects:
    [
      Shared.Services.AppStatusServiceProtocol
    ]
)

let project = surcharges.project(targets: [target])
