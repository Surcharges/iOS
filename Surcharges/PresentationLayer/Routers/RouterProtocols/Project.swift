import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: PresentationLayer.Routers.RouterProtocols)

let target = surcharges.target(
  projects:
    [
      
    ],
  externalPackages: 
    [
      
  ]
)

let project = surcharges.project(targets: [target])
