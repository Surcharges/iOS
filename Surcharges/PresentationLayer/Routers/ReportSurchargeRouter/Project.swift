import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: PresentationLayer.Routers.ReportSurchargeRouter)

let target = surcharges.target(
  projects:
    [
      PresentationLayer.Routers.RouterProtocols,
    ],
  externalPackages: 
    [
      
  ]
)

let project = surcharges.project(targets: [target])
