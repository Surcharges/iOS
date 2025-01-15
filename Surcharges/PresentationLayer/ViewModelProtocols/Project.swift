import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: PresentationLayer.ViewModelProtocols)

let target = surcharges.target(
  projects:
    [
      PresentationLayer.Models,
    ]
)

let project = surcharges.project(targets: [target])
