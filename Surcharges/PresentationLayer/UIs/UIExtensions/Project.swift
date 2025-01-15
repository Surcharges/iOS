import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: PresentationLayer.UIs.UIExtensions)

let target = surcharges.target(
  projects:
    [
      
    ],
  externalPackages:
    [
      
    ]
)

let project = surcharges.project(targets: [target])
