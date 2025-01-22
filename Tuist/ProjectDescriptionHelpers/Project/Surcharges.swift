import ProjectDescription
import ModularPlugin

public final class Surcharges: @unchecked Sendable {
  
  private let _project: ModularPlugin.Project
  private let _developmentTeam = "PN8663UTBA"
  
  private var _hasDemo: Bool = false
  
  private let _schemeArguments: Arguments = .arguments(
    environmentVariables: ["OS_ACTIVITY_MODE": "disable"],
    launchArguments: []
  )
  
  public init(project: ModularPlugin.Project) {
    _project = project
  }
  
  public func target(
    hasResources: Bool = false,
    projects: [ModularPlugin.Project],
    scripts: [TargetScript] = [],
    externalPackages: [TargetDependency] = []
  ) -> Target {
    return .target(
      name: _project.name,
      destinations: [.iPhone, .iPad, .mac],
      product: .framework,
      bundleId:  _project.bundleId,
      deploymentTargets: .multiplatform(iOS: "17.0", macOS: "13.0"),
      infoPlist: .extendingDefault(
        with: [
          "UILaunchScreen": [
            "UIColorName": "",
            "UIImageName": "",
          ],
          "NSHumanReadableCopyright": .string("©2025 Bonsung Koo. All rights reserved.")
        ]
      ),
      sources: ["Sources/**"],
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
        base: SettingsDictionary()
          .swiftVersion("6.0")
          .bitcodeEnabled(false)
          .currentProjectVersion("1")
          .marketingVersion("1.0.0"),
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
      destinations: [.iPhone, .iPad, .mac],
      product: .app,
      bundleId: "\( _project.bundleId)Demo",
      deploymentTargets: .multiplatform(iOS: "17.0", macOS: "13.0"),
      infoPlist: .extendingDefault(
        with: [
          "UILaunchScreen": [
            "UIColorName": "",
            "UIImageName": "",
          ],
          "NSHumanReadableCopyright": .string("©2025 Bonsung Koo. All rights reserved."),
          "NSLocationWhenInUseUsageDescription": .string("Surcharges uses your location to provide nearest places to you.")
        ]
      ),
      sources: ["App/Sources/**"],
      dependencies: _dependencies + [ExternalPackages.PresentationLayer.ToastUI],
      settings: Settings.settings(
        base: SettingsDictionary()
          .swiftVersion("6.0")
          .bitcodeEnabled(false)
          .currentProjectVersion("1")
          .marketingVersion("1.0.0")
          .automaticCodeSigning(devTeam: _developmentTeam)
          .developmentTeam(_developmentTeam),
        debug: SettingsDictionary()
          .developmentTeam(_developmentTeam)
          .automaticCodeSigning(devTeam: _developmentTeam)
          .developmentTeam(_developmentTeam),
        release: SettingsDictionary()
          .developmentTeam(_developmentTeam)
          .automaticCodeSigning(devTeam: _developmentTeam)
          .developmentTeam(_developmentTeam),
        defaultSettings: .recommended
      )
    )
  }
  
  private var _schemes: [Scheme] {
    get {
      var demo: Scheme? {
        
        if _hasDemo {
          return .scheme(
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
        } else {
          return nil
        }
      }
      
      return [
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
        ),
        demo
      ]
        .compactMap { $0 }
    }
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
      schemes: _schemes,
      resourceSynthesizers: []
    )
  }
}
