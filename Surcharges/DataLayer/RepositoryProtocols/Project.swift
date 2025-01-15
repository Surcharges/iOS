import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: DataLayer.RepositoryProtocols)

let target = surcharges.target(
  projects:
    [
      DataLayer.DTOs,
    ]
)

let project = surcharges.project(targets: [target])
