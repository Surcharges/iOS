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
      PresentationLayer.UIs.MobileAds,
      Shared.Services.AdsServiceProtocol,
    ],
  externalPackages:
    [
      
    ]
)

let demo = surcharges.demo(
  projects: [
    Builder.Factories,
    DataSource.DevelopmentEndpoint,
    Shared.Services.DevelopmentAdsService,
    PresentationLayer.Routers.MainRouter,
    PresentationLayer.UIs.Main,
    PresentationLayer.UIs.SurchargeStatusHelp,
    PresentationLayer.UIs.Toast,
  ]
)

let project = surcharges.project(targets: [target, demo])
