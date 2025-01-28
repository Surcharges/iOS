#!/bin/sh

#  make_endpoint.sh
#  
#
#  Created by Bonsung Koo on 28/01/2025.
#  

echo "import Foundation" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/ProductionEndpoint/Sources/ProductionEndpoint.swift
echo "import EndpointProtocol" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/ProductionEndpoint/Sources/ProductionEndpoint.swift
echo "public struct ProductionEndpoint: EndpointProtocol {" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/ProductionEndpoint/Sources/ProductionEndpoint.swift
echo "public init() { }" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/ProductionEndpoint/Sources/ProductionEndpoint.swift
echo "public var baseURL: String {" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/ProductionEndpoint/Sources/ProductionEndpoint.swift
echo "return \"$BASE_URL\"" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/ProductionEndpoint/Sources/ProductionEndpoint.swift
echo "}" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/ProductionEndpoint/Sources/ProductionEndpoint.swift
echo "public var authorisationScheme: String {" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/ProductionEndpoint/Sources/ProductionEndpoint.swift
echo "return \"$AUTHORISATION_SCHEME\"" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/ProductionEndpoint/Sources/ProductionEndpoint.swift
echo "}" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/ProductionEndpoint/Sources/ProductionEndpoint.swift
echo "public var authorisationToken: String {" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/ProductionEndpoint/Sources/ProductionEndpoint.swift
echo "return \"$AUTHORISATION_TOKEN\"" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/ProductionEndpoint/Sources/ProductionEndpoint.swift
echo "}" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/ProductionEndpoint/Sources/ProductionEndpoint.swift
echo "}" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/ProductionEndpoint/Sources/ProductionEndpoint.swift