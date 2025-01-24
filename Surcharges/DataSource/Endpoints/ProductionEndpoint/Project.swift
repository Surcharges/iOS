import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: DataSource.ProductionEndpoint)

let target = surcharges.target(
  projects:
    [
      DataSource.EndpointProtocol,
    ]
)

let project = surcharges.project(targets: [target])
