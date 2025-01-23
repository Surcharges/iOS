import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: Builder.Factories)

let target = surcharges.target(
  projects:
    [
      Builder.FactoryProtocols,
      PresentationLayer.ViewModels,
      DomainLayer.UseCases,
      DataLayer.Repositories,
      Shared.Services.AppStatusService,
      Shared.Services.LocationService,
      Shared.Services.ViewUpdateService,
    ]
)

let project = surcharges.project(targets: [target])
