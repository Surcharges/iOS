import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: DataLayer.Repositories)

let target = surcharges.target(
  projects:
    [
      DataLayer.RepositoryProtocols,
      DataLayer.Networks,
    ]
)

let project = surcharges.project(targets: [target])
