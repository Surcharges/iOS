#!/bin/sh

#  make_endpoint.sh
#  
#
#  Created by Bonsung Koo on 28/01/2025.
#  

echo "import Foundation" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/DevelopmentEndpoint/Sources/DevelopmentEndpoint.swift
echo "import EndpointProtocol" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/DevelopmentEndpoint/Sources/DevelopmentEndpoint.swift
echo "public struct ProductionEndpoint: EndpointProtocol {" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/DevelopmentEndpoint/Sources/DevelopmentEndpoint.swift
echo "public init() { }" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/DevelopmentEndpoint/Sources/DevelopmentEndpoint.swift
echo "public var baseURL: String {" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/DevelopmentEndpoint/Sources/DevelopmentEndpoint.swift
echo "return \"$BASE_URL_DEV\"" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/DevelopmentEndpoint/Sources/DevelopmentEndpoint.swift
echo "}" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/DevelopmentEndpoint/Sources/DevelopmentEndpoint.swift
echo "public var authorisationScheme: String {" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/DevelopmentEndpoint/Sources/DevelopmentEndpoint.swift
echo "return \"$AUTHORISATION_SCHEME_DEV\"" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/DevelopmentEndpoint/Sources/DevelopmentEndpoint.swift
echo "}" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/DevelopmentEndpoint/Sources/DevelopmentEndpoint.swift
echo "public var authorisationToken: String {" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/DevelopmentEndpoint/Sources/DevelopmentEndpoint.swift
echo "return \"$AUTHORISATION_TOKEN_DEV\"" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/DevelopmentEndpoint/Sources/DevelopmentEndpoint.swift
echo "}" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/DevelopmentEndpoint/Sources/DevelopmentEndpoint.swift
echo "}" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/DevelopmentEndpoint/Sources/DevelopmentEndpoint.swift