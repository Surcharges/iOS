import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: Shared.Google.FirebaseSDKs)

let target = surcharges.target(
  hasSources: false,
  projects:
    [
      
    ],
  externalPackages:
    [
      ExternalPackages.Google.Firebase.Core,
      ExternalPackages.Google.Firebase.Analytics,
      ExternalPackages.Google.Firebase.Crashlytics,
      
    ],
  baseSettings: SettingsDictionary()
    .swiftVersion("6.0")
    .bitcodeEnabled(false)
    .otherLinkerFlags(["-ObjC"])
)

let project = surcharges.project(targets: [target])
