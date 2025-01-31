#!/bin/sh

#  make_endpoint.sh
#  
#
#  Created by Bonsung Koo on 28/01/2025.
#  

FILE_PATH=$CI_PRIMARY_REPOSITORY_PATH/Surcharges/DataSource/Endpoints/ProductionEndpoint/Sources/ProductionEndpoint.swift

echo "import Foundation" >> $FILE_PATH
echo "import EndpointProtocol" >> $FILE_PATH
echo "public struct ProductionEndpoint: EndpointProtocol {" >> $FILE_PATH
echo "public init() { }" >> $FILE_PATH
echo "public var baseURL: String {" >> $FILE_PATH
echo "return \"$BASE_URL\"" >> $FILE_PATH
echo "}" >> $FILE_PATH
echo "public var authorisationScheme: String {" >> $FILE_PATH
echo "return \"$AUTHORISATION_SCHEME\"" >> $FILE_PATH
echo "}" >> $FILE_PATH
echo "public var authorisationToken: String {" >> $FILE_PATH
echo "return \"$AUTHORISATION_TOKEN\"" >> $FILE_PATH
echo "}" >> $FILE_PATH
echo "}" >> $FILE_PATH