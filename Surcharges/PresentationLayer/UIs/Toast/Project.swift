import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: PresentationLayer.UIs.Toast)

let target = surcharges.target(
  projects:
    [
      Shared.Services.AppStatusServiceProtocol,
    ],
  externalPackages:
    [
      ExternalPackages.PresentationLayer.ToastUI,
    ]
)

let project = surcharges.project(targets: [target])
