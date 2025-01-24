import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: DataLayer.Networks)

let target = surcharges.target(
  projects:
    [
      DataSource.EndpointProtocol,
    ],
  externalPackages: 
    [
      ExternalPackages.DataLayer.Alamofire
  ]
)

let project = surcharges.project(targets: [target])
