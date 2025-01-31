import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: Shared.Services.DevelopmentAdsService)

let target = surcharges.target(
  projects:
    [
      Shared.Services.AdsServiceProtocol
    ]
)

let project = surcharges.project(targets: [target])
