import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

enum Configuration {
  case dev, prod
}

func getDependencies(_ config: Configuration) -> [TargetDependency] {
  
  var projects: [ModularPlugin.Project] = [
    Builder.Factories,
    PresentationLayer.Routers.MainRouter,
    PresentationLayer.Routers.PlaceDetailRouter,
    PresentationLayer.Routers.ReportSurchargeRouter,
    PresentationLayer.UIs.Main,
    PresentationLayer.UIs.PlaceDetail,
    PresentationLayer.UIs.ReportSurcharge,
    PresentationLayer.UIs.SurchargeStatusHelp,
    PresentationLayer.UIs.Toast,
  ]
  
  switch config {
  case .dev:
    projects.append(DataSource.DevelopmentEndpoint)
  case .prod:
    projects.append(DataSource.ProductionEndpoint)
  }
  
  return projects.map {
    .project(target: $0.name, path: .relativeToRoot($0.path))
  }
}

// MARK: Dependencies: Prod
let productionDependencies: [TargetDependency] = getDependencies(.prod)


// MARK: Dependencies: Dev
let developmentDependencies: [TargetDependency] = getDependencies(.dev)

// MARK: External Dependencies
let externalDependencies: [TargetDependency] = [
  ExternalPackages.Firebase.Core,
  ExternalPackages.Firebase.Analytics,
  ExternalPackages.Firebase.Crashlytics,
]

// MARK: Target - Infomation
let developmentTeam = Environment.developmentTeam.getString(default: "None")
let appVersion = Environment.appVersion.getString(default: "1.0.0")

let baseSetting = SettingsDictionary()
  .swiftVersion("6.0")
  .bitcodeEnabled(false)
  .marketingVersion(appVersion)
  .otherLinkerFlags(["-ObjC"])
  .automaticCodeSigning(devTeam: developmentTeam)

let debugSetting = SettingsDictionary()

let releaseSetting = SettingsDictionary()

// MARK: Plist
let infoPlist: InfoPlist = .extendingDefault(
  with: [
    "UILaunchScreen": [
      "UIColorName": "",
      "UIImageName": "",
    ],
    "CFBundleShortVersionString": .string(appVersion),
    "NSHumanReadableCopyright": .string("©2025 Bonsung Koo. All rights reserved."),
    "NSLocationWhenInUseUsageDescription": .string("Surcharges uses your location to provide nearest places to you."),
    "NSCameraUsageDescription": .string("Surcharges uses your camera to take your receipt."),
    "ITSAppUsesNonExemptEncryption": .boolean(false),
    "UISupportedInterfaceOrientations": .array([.string("UIInterfaceOrientationPortrait")])
  ]
)

// MARK: Target - Prod
let surcharges = Target.target(
  name: "Surcharges",
  destinations: [.iPhone],
  product: .app,
  bundleId: "nz.surcharges",
  deploymentTargets: .iOS("17.0"),
  infoPlist: infoPlist,
  sources: ["Sources/Commons/**", "Sources/Prod/**"],
  resources: .resources(
    [
      "Resources/Localise/**",
      .glob(
        pattern: .relativeToManifest("Resources/Prod/**"),
        excluding: [.relativeToManifest("Resources/Prod/.gitkeep")]
      ),
    ],
    privacyManifest: .default
  ),
  dependencies: productionDependencies + externalDependencies,
  settings: Settings.settings(
    base: baseSetting,
    debug: debugSetting,
    release: releaseSetting,
    defaultSettings: .recommended
  )
)

// MARK: Target - Dev
let surchargesDev = Target.target(
  name: "SurchargesDev",
  destinations: [.iPhone],
  product: .app,
  bundleId: "nz.surcharges.development",
  deploymentTargets: .iOS("17.0"),
  infoPlist: infoPlist,
  sources: ["Sources/Commons/**", "Sources/Dev/**"],
  resources: .resources(
    [
      "Resources/Localise/**",
      .glob(
        pattern: .relativeToManifest("Resources/Dev/**"),
        excluding: [.relativeToManifest("Resources/Dev/.gitkeep")]
      ),
    ],
    privacyManifest: .default
  ),
  dependencies: developmentDependencies + externalDependencies,
  settings: Settings.settings(
    base: baseSetting,
    debug: debugSetting,
    release: releaseSetting,
    defaultSettings: .recommended
  )
)

// MARK: Schemes - Infomation
let schemeArguments: Arguments = .arguments(
  environmentVariables: ["OS_ACTIVITY_MODE": "disable"],
  launchArguments: []
)

// MARK: Schemes
let schemes: [Scheme] = [
  .scheme(
    name: "Surcharges",
    shared: true,
    hidden: false,
    buildAction: .buildAction(
      targets: [TargetReference(stringLiteral: "Surcharges")]
    ),
    testAction: nil,
    runAction: RunAction.runAction(
      configuration: ProjectDescription.ConfigurationName(stringLiteral: "debug"),
      executable: TargetReference(stringLiteral: "Surcharges"),
      arguments: schemeArguments
    ),
    archiveAction: ArchiveAction.archiveAction(
      configuration: ProjectDescription.ConfigurationName(stringLiteral: "release")
    ),
    profileAction: nil,
    analyzeAction: nil
  ),
  .scheme(
    name: "SurchargesDev",
    shared: true,
    hidden: false,
    buildAction: .buildAction(
      targets: [TargetReference(stringLiteral: "SurchargesDev")]
    ),
    testAction: nil,
    runAction: RunAction.runAction(
      configuration: ProjectDescription.ConfigurationName(stringLiteral: "debug"),
      executable: TargetReference(stringLiteral: "SurchargesDev"),
      arguments: schemeArguments
    ),
    archiveAction: ArchiveAction.archiveAction(
      configuration: ProjectDescription.ConfigurationName(stringLiteral: "release")
    ),
    profileAction: nil,
    analyzeAction: nil
  )
]

// MARK: Project
let project = Project(
  name: "Applications",
  organizationName: "Surcharges",
  options: Project.Options.options(
    automaticSchemesOptions: .disabled,
    developmentRegion: "en",
    disableBundleAccessors: true,
    disableShowEnvironmentVarsInScriptPhases: true,
    disableSynthesizedResourceAccessors: true,
    textSettings: .textSettings(usesTabs: true, indentWidth: 2, tabWidth: 2, wrapsLines: true),
    xcodeProjectName: "Applications"
  ),
  packages: Packages.all,
  settings:
    Settings.settings(
      configurations:
        [
          .debug(name: "debug"),
          .release(name: "release")
        ]
    ),
  targets: [
    surcharges,
    surchargesDev
  ],
  schemes: schemes,
  fileHeaderTemplate: nil,
  resourceSynthesizers: []
)
