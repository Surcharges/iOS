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
    PresentationLayer.Routers.MainRouter,
    PresentationLayer.UIs.Main,
  ]
)

let project = surcharges.project(targets: [target, demo])
