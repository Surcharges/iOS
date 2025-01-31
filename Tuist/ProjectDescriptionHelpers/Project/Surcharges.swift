import ProjectDescription
import ModularPlugin

public final class Surcharges: @unchecked Sendable {
  
  private let _project: ModularPlugin.Project
  
  private var _hasDemo: Bool = false
  private var _hasTests: Bool = false
  
  private let _schemeArguments: Arguments = .arguments(
    environmentVariables: ["OS_ACTIVITY_MODE": "disable"],
    launchArguments: []
  )
  
  public init(project: ModularPlugin.Project) {
    _project = project
  }
  
  public func target(
    hasSources: Bool = true,
    hasResources: Bool = false,
    projects: [ModularPlugin.Project],
    scripts: [TargetScript] = [],
    externalPackages: [TargetDependency] = [],
    baseSettings: SettingsDictionary? = nil
  ) -> Target {
    
    var _baseSettings: SettingsDictionary {
      if let baseSettings = baseSettings {
        return baseSettings
      } else {
        return SettingsDictionary()
          .swiftVersion("6.0")
          .bitcodeEnabled(false)
      }
    }
    
    return .target(
      name: _project.name,
      destinations: [.iPhone],
      product: .framework,
      bundleId:  _project.bundleId,
      deploymentTargets: .iOS("17.0"),
      infoPlist: .extendingDefault(
        with: [
          "UILaunchScreen": [
            "UIColorName": "",
            "UIImageName": "",
          ],
          "NSHumanReadableCopyright": .string("©2025 Bonsung Koo. All rights reserved.")
        ]
      ),
      sources: hasSources ? ["Sources/**"] : nil,
      resources: hasResources ? .resources(["Resources/**"], privacyManifest: .default) : nil,
      scripts: scripts,
      dependencies: projects
        .map {
          TargetDependency.project(
            target: $0.name,
            path: .relativeToRoot($0.path)
          )
        } + externalPackages,
      settings: Settings.settings(
        base: _baseSettings,
        debug: SettingsDictionary(),
        release: SettingsDictionary(),
        defaultSettings: .recommended
      )
    )
  }
  
  public func demo(projects: [ModularPlugin.Project]) -> Target {
    
    _hasDemo = true
    
    var _dependencies: [TargetDependency] = projects
      .map {
        .project(
          target: $0.name,
          path: .relativeToRoot($0.path)
        )
      }
    
    _dependencies.append(.target(name: _project.name))
    
    return  .target(
      name: "\(_project.name)Demo",
      destinations: [.iPhone],
      product: .app,
      bundleId: "\( _project.bundleId)Demo",
      deploymentTargets: .iOS("17.0"),
      infoPlist: .extendingDefault(
        with: [
          "UILaunchScreen": [
            "UIColorName": "",
            "UIImageName": "",
          ],
          "NSHumanReadableCopyright": .string("©2025 Bonsung Koo. All rights reserved."),
          "NSLocationWhenInUseUsageDescription": .string("Surcharges uses your location to provide nearest places to you."),
          "NSCameraUsageDescription": .string("Surcharges uses your camera to take your receipt."),
          "ITSAppUsesNonExemptEncryption": .boolean(false),
          "UISupportedInterfaceOrientations": .array([.string("UIInterfaceOrientationPortrait")])
        ]
      ),
      sources: ["App/Sources/**"],
      dependencies: _dependencies,
      settings: Settings.settings(
        base: SettingsDictionary()
          .swiftVersion("6.0")
          .bitcodeEnabled(false)
          .codeSignIdentityAppleDevelopment(),
        debug: SettingsDictionary(),
        release: SettingsDictionary(),
        defaultSettings: .recommended
      )
    )
  }
  
  public func test(projects: [ModularPlugin.Project]) -> Target {
    
    _hasTests = true
    
    return .target(
      name: "\(_project.name)Tests",
      destinations: [.iPhone],
      product: .unitTests,
      bundleId: "\( _project.bundleId)Tests",
      deploymentTargets: .iOS("17.0"),
      sources: ["Tests/**"],
      dependencies: projects
        .map {
          TargetDependency.project(
            target: $0.name,
            path: .relativeToRoot($0.path)
          )
        },
      settings: Settings.settings(
        base: SettingsDictionary()
          .swiftVersion("6.0")
          .bitcodeEnabled(false),
        debug: SettingsDictionary(),
        release: SettingsDictionary(),
        defaultSettings: .recommended
      )
    )
  }
  
  private func _getSchemes() -> [Scheme] {
    
    var schemes: [Scheme] = [
      .scheme(
        name: _project.name,
        shared: true,
        hidden: false,
        buildAction: .buildAction(
          targets: [TargetReference(stringLiteral: _project.name)]
        ),
        testAction: nil,
        runAction: .runAction(
          configuration: .init(stringLiteral: "debug"),
          executable: .init(stringLiteral: _project.name),
          arguments: _schemeArguments
        ),
        archiveAction: nil,
        profileAction: nil,
        analyzeAction: nil
      )
    ]
    
    if _hasDemo {
      schemes.append(
        .scheme(
          name: "\(_project.name)Demo",
          shared: true,
          hidden: false,
          buildAction: .buildAction(
            targets: [TargetReference(stringLiteral: "\(_project.name)Demo")]
          ),
          testAction: nil,
          runAction: .runAction(
            configuration: .init(stringLiteral: "debug"),
            executable: .init(stringLiteral: "\(_project.name)Demo"),
            arguments: _schemeArguments
          ),
          archiveAction: nil,
          profileAction: nil,
          analyzeAction: nil
        )
      )
    }
    
    if _hasTests {
      schemes.append(
        .scheme(
          name: "\(_project.name)Tests",
          shared: true,
          hidden: false,
          buildAction: .buildAction(
            targets: [TargetReference(stringLiteral: "\(_project.name)Tests")]
          ),
          testAction: .targets(
            [.testableTarget(target: "\(_project.name)Tests")],
            configuration: .init(stringLiteral: "debug")
          ),
          runAction: nil,
          archiveAction: nil,
          profileAction: nil,
          analyzeAction: nil
        )
      )
    }
    
    return schemes
  }
  
  public func project(targets: [Target]) -> ProjectDescription.Project {
    ProjectDescription.Project(
      name: _project.name,
      organizationName: "Surcharges",
      options: Project.Options.options(
        automaticSchemesOptions: .disabled,
        developmentRegion: "en",
        disableBundleAccessors: true,
        disableShowEnvironmentVarsInScriptPhases: true,
        disableSynthesizedResourceAccessors: true,
        textSettings: .textSettings(usesTabs: true, indentWidth: 2, tabWidth: 2, wrapsLines: true),
        xcodeProjectName: _project.name
      ),
      settings: Settings.settings(
        configurations:
          [
            .debug(name: "debug"),
            .release(name: "release")
          ]
      ),
      targets: targets,
      schemes: _getSchemes(),
      resourceSynthesizers: []
    )
  }
}
