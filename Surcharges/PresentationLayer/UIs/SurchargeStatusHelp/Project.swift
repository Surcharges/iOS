import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: PresentationLayer.UIs.SurchargeStatusHelp)

let target = surcharges.target(
  projects:
    [
      PresentationLayer.UIs.CommonUI
    ],
  externalPackages: 
    [
      
  ]
)

let demo = surcharges.demo(
  projects: [
    PresentationLayer.UIs.SurchargeStatusHelp
  ]
)

let project = surcharges.project(targets: [target, demo])
