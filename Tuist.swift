import ProjectDescription

let config = Config(
  swiftVersion: "6.0",
  plugins: [
    .local(path: .relativeToRoot("ModularPlugin"))
  ]
)
