import ProjectDescription

extension SettingsDictionary {
  public func developmentTeam(_ team: String) -> SettingsDictionary {
    merging(["DEVELOPMENT_TEAM": SettingValue.string(team)])
  }
}
