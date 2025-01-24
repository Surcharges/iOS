import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: DataSource.DevelopmentEndpoint)

let target = surcharges.target(
  projects:
    [
      DataSource.EndpointProtocol,
    ]
)

let project = surcharges.project(targets: [target])
