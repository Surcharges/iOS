import ProjectDescription

public extension PrivacyManifest {
  static var `default`: PrivacyManifest {
    return privacyManifest(
      tracking: false,
      trackingDomains: [],
      collectedDataTypes: [
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeName",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": [
            "NSPrivacyCollectedDataTypePurposeAppFunctionality",
          ],
        ],
      ],
      accessedApiTypes: [
        [
          "NSPrivacyAccessedAPIType": "NSPrivacyAccessedAPICategoryUserDefaults",
          "NSPrivacyAccessedAPITypeReasons": [
            "CA92.1",
          ],
        ],
      ]
    )
  }
}
