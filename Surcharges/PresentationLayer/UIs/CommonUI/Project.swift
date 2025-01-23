import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: PresentationLayer.UIs.CommonUI)

let target = surcharges.target(
  projects:
    [
      PresentationLayer.UIs.UIExtensions,
      PresentationLayer.UIs.Resources,
    ],
  externalPackages:
    [
      ExternalPackages.PresentationLayer.Shimmer,
      ExternalPackages.PresentationLayer.Confetti
  ]
)

let project = surcharges.project(targets: [target])
