import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: DomainLayer.UseCaseProtocols)

let target = surcharges.target(
  projects:
    [
      DomainLayer.Entities,
    ]
)

let project = surcharges.project(targets: [target])
