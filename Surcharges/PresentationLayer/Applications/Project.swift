import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

// MARK: Dependencies
let projects: [ModularPlugin.Project] = [
  Builder.Factories,
  PresentationLayer.Routers.MainRouter,
  PresentationLayer.Routers.PlaceDetailRouter,
  PresentationLayer.Routers.ReportSurchargeRouter,
  PresentationLayer.UIs.Main,
  PresentationLayer.UIs.PlaceDetail,
  PresentationLayer.UIs.ReportSurcharge,
  PresentationLayer.UIs.SurchargeStatusHelp,
]

let projectDependencies: [TargetDependency] = projects.map {
  .project(target: $0.name, path: .relativeToRoot($0.path))
}

// MARK: Target - Infomation
let developmentTeam = "PN8663UTBA"
let projectVersion = "1"
let marketingVersion = "1.0.0"

let baseSetting = SettingsDictionary()
  .swiftVersion("6.0")
  .bitcodeEnabled(false)
  .currentProjectVersion(projectVersion)
  .marketingVersion(marketingVersion)
  .automaticCodeSigning(devTeam: developmentTeam)
  .developmentTeam(developmentTeam)

let debugSetting = SettingsDictionary()
  .automaticCodeSigning(devTeam: developmentTeam)
  .developmentTeam(developmentTeam)

let releaseSetting = SettingsDictionary()
  .automaticCodeSigning(devTeam: developmentTeam)
  .developmentTeam(developmentTeam)

// MARK: Target
let surcharges = Target.target(
  name: "Surcharges",
  destinations: [.iPhone, .iPad, .mac],
  product: .app,
  bundleId: "nz.surcharges",
  deploymentTargets: .multiplatform(iOS: "17.0", macOS: "13.0"),
  infoPlist: .extendingDefault(
    with: [
      "UILaunchScreen": [
        "UIColorName": "",
        "UIImageName": "",
      ],
      "NSHumanReadableCopyright": .string("©2025 Bonsung Koo. All rights reserved."),
      "NSLocationWhenInUseUsageDescription": .string("Surcharges uses your location to provide nearest places to you."),
      "NSCameraUsageDescription": .string("Surcharges uses your camera to take your receipt."),
    ]
  ),
  sources: ["Sources/**"],
  resources: .resources([], privacyManifest: .default),
  dependencies: projectDependencies + [ExternalPackages.PresentationLayer.ToastUI],
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
    surcharges
  ],
  schemes: schemes,
  fileHeaderTemplate: nil,
  resourceSynthesizers: []
)
