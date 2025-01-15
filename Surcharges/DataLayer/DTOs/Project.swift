import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: DataLayer.DTOs)

let target = surcharges.target(
  projects:
    [
      
    ]
)

let project = surcharges.project(targets: [target])
