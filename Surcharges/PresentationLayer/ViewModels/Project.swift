import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: PresentationLayer.ViewModels)

let target = surcharges.target(
  projects:
    [
      PresentationLayer.ViewModelProtocols,
      DomainLayer.UseCaseProtocols,
      Shared.ServiceProtocols
    ]
)

let project = surcharges.project(targets: [target])
