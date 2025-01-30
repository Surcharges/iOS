#!/bin/sh

#  ci_post_clone.sh
#  
#
#  Created by Bonsung Koo on 28/01/2025.
#  

curl https://mise.jdx.dev/install.sh | sh

/Users/local/.local/bin/mise install # Installs the version from .mise.toml

if [[ -n $CI_PULL_REQUEST_NUMBER ]];
then

  cd ..

  /Users/local/.local/bin/mise exec -- tuist generate UseCasesTests ViewModelsTests --no-open

elif [[ -n $CI_TAG ]];
then
  
  sh ./make_files/prod/make_endpoint.sh
  sh ./make_files/prod/make_firebase.sh

  cd ..

  TUIST_APP_VERSION=$CI_TAG TUIST_DEVELOPMENT_TEAM=$DEVELOPMENT_TEAM /Users/local/.local/bin/mise exec -- tuist generate Surcharges --no-open

else

  sh ./make_files/dev/make_endpoint.sh
  sh ./make_files/dev/make_firebase.sh

  cd ..

  TUIST_DEVELOPMENT_TEAM=$DEVELOPMENT_TEAM /Users/local/.local/bin/mise exec -- tuist generate SurchargesDev --no-open

fi