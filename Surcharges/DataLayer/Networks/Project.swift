import ProjectDescription
import ProjectDescriptionHelpers
import ModularPlugin

let surcharges = Surcharges(project: DataLayer.Networks)

let target = surcharges.target(
  projects:
    [
      DataSource.EndpointProtocol,
      DataLayer.DTOs,
    ],
  externalPackages: 
    [
      ExternalPackages.DataLayer.Alamofire
  ]
)

let project = surcharges.project(targets: [target])
