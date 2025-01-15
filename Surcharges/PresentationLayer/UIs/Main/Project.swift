import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: PresentationLayer.UIs.Main)

let target = surcharges.target(
  projects:
    [
      PresentationLayer.ViewModelProtocols,
      PresentationLayer.UIs.CommonUI,
    ],
  externalPackages: 
    [
      
  ]
)

let demo = surcharges.demo(
  projects: [
    Builder.Factories,
  ]
)

let project = surcharges.project(targets: [target, demo])
