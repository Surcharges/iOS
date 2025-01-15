import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: DomainLayer.UseCases)

let target = surcharges.target(
  projects:
    [
      DomainLayer.UseCaseProtocols,
      DataLayer.RepositoryProtocols,
    ]
)

let project = surcharges.project(targets: [target])
