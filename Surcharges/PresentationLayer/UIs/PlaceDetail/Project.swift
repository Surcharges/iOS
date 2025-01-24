import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: PresentationLayer.UIs.PlaceDetail)

let target = surcharges.target(
  projects:
    [
      PresentationLayer.ViewModelProtocols,
      PresentationLayer.UIs.CommonUI,
      PresentationLayer.Routers.RouterProtocols,
    ],
  externalPackages: 
    [
      
  ]
)

let demo = surcharges.demo(
  projects: [
    Builder.Factories,
    DataSource.DevelopmentEndpoint,
    PresentationLayer.Routers.PlaceDetailRouter,
    PresentationLayer.UIs.PlaceDetail
  ]
)

let project = surcharges.project(targets: [target, demo])
