import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: PresentationLayer.ViewModels)

let target = surcharges.target(
  projects:
    [
      PresentationLayer.ViewModelProtocols,
      DomainLayer.UseCaseProtocols,
      Shared.Services.LocationServiceProtocol,
      Shared.Services.ViewUpdateServiceProtocol,
    ]
)

let tests = surcharges.test(
  projects: [
    PresentationLayer.ViewModels,
    DomainLayer.UseCaseProtocols,
  ]
)

let project = surcharges.project(targets: [target, tests])
