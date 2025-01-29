#!/bin/sh

#  ci_post_clone.sh
#  
#
#  Created by Bonsung Koo on 28/01/2025.
#  

curl https://mise.jdx.dev/install.sh | sh

/Users/local/.local/bin/mise install # Installs the version from .mise.toml

echo $CI_TAG

sh ./make_files/make_endpoint.sh
sh ./make_files/make_firebase.sh

cd ..

TUIST_APP_VERSION=$CI_TAG TUIST_DEVELOPMENT_TEAM=$DEVELOPMENT_TEAM /Users/local/.local/bin/mise exec -- tuist generate --no-open