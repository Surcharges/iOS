import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let project = ProjectDescription.Project(
  name: PresentationLayer.UIs.Resources.name,
  organizationName: "Surcharges",
  options: Project.Options.options(
    automaticSchemesOptions: .disabled,
    developmentRegion: "en",
    disableBundleAccessors: true,
    disableShowEnvironmentVarsInScriptPhases: true,
    disableSynthesizedResourceAccessors: true,
    textSettings: .textSettings(usesTabs: true, indentWidth: 2, tabWidth: 2, wrapsLines: true),
    xcodeProjectName: PresentationLayer.UIs.Resources.name
  ),
  packages: [
    .remote(url: "https://github.com/mac-cain13/R.swift", requirement: .exact("7.8.0"))
  ],
  settings: Settings.settings(
    configurations:
      [
        .debug(name: "debug"),
        .release(name: "release")
      ]
  ),
  targets: [
    Target.target(
      name: PresentationLayer.UIs.Resources.name,
      destinations: [.iPhone],
      product: .framework,
      bundleId: PresentationLayer.UIs.Resources.bundleId,
      deploymentTargets: .iOS("17.0"),
      sources: ["Sources/**"],
      resources: .resources(["Resources/**"], privacyManifest: .default),
      dependencies: [
        .package(product: "RswiftLibrary", type: .runtime),
        .package(product: "RswiftGeneratePublicResources", type: .plugin)
      ],
      settings: Settings.settings(
        base: SettingsDictionary()
          .swiftVersion("6.0")
          .bitcodeEnabled(false),
        debug: SettingsDictionary(),
        release: SettingsDictionary(),
        defaultSettings: .recommended
      )
    )
  ],
  schemes: [
    Scheme.scheme(
      name: PresentationLayer.UIs.Resources.name,
      shared: true,
      hidden: false,
      buildAction: .buildAction(
        targets: [TargetReference(stringLiteral: PresentationLayer.UIs.Resources.name)]
      ),
      testAction: nil,
      runAction: .runAction(
        configuration: .init(stringLiteral: "debug"),
        executable: .init(stringLiteral: PresentationLayer.UIs.Resources.name),
        arguments: .arguments(
          environmentVariables: ["OS_ACTIVITY_MODE": "disable"],
          launchArguments: []
        )
      ),
      archiveAction: nil,
      profileAction: nil,
      analyzeAction: nil
    )
  ]
)
