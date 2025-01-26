import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: PresentationLayer.UIs.Main)

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
    PresentationLayer.Routers.MainRouter,
    PresentationLayer.UIs.Main,
    PresentationLayer.UIs.SurchargeStatusHelp,
    PresentationLayer.UIs.Toast,
  ]
)

let project = surcharges.project(targets: [target, demo])
