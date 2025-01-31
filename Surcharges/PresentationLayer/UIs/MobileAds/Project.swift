import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: PresentationLayer.UIs.MobileAds)

let target = surcharges.target(
  projects:
    [
      PresentationLayer.UIs.UIExtensions,
      PresentationLayer.UIs.Resources,
    ],
  externalPackages:
    [
      ExternalPackages.PresentationLayer.Lottie,
      ExternalPackages.Google.MobileAds,
      .sdk(name: "JavaScriptCore", type: .framework),
    ],
  baseSettings: SettingsDictionary()
    .swiftVersion("6.0")
    .bitcodeEnabled(false)
    .otherLinkerFlags(["-ObjC"])
)

let project = surcharges.project(targets: [target])
