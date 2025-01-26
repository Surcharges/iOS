import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: PresentationLayer.UIs.ReportSurcharge)

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
    PresentationLayer.Routers.ReportSurchargeRouter,
    PresentationLayer.UIs.ReportSurcharge,
    PresentationLayer.UIs.Toast,
  ]
)

let project = surcharges.project(targets: [target, demo])
