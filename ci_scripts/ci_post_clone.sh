#!/bin/sh

#  ci_post_clone.sh
#  
#
#  Created by Bonsung Koo on 28/01/2025.
#  

curl https://mise.jdx.dev/install.sh | sh

/Users/local/.local/bin/mise install # Installs the version from .mise.toml


if [ $CI_WORKFLOW_ID = 'DF8E0AB2-31E7-450B-B956-B1F0D3EC3CAF' ]; 
then
  
  # Dev release workflow

  sh ./make_files/dev/make_endpoint.sh
  sh ./make_files/dev/make_firebase.sh
  sh ./make_files/dev/make_adsService.sh

  cd ..

  TUIST_DEVELOPMENT_TEAM=$DEVELOPMENT_TEAM /Users/local/.local/bin/mise exec -- tuist generate --no-open

else
  
  # Prod release, Prod tests workflow
  
  if [[ -n $CI_PULL_REQUEST_NUMBER ]];
  then
    
    # Prod tests workflow
    
    cd ..

    /Users/local/.local/bin/mise exec -- tuist generate UseCasesTests ViewModelsTests --no-open

  else

    # Prod release workflow
  
    sh ./make_files/prod/make_endpoint.sh
    sh ./make_files/prod/make_firebase.sh
    sh ./make_files/prod/make_adsService.sh

    cd ..

    TUIST_APP_VERSION=$CI_TAG TUIST_DEVELOPMENT_TEAM=$DEVELOPMENT_TEAM /Users/local/.local/bin/mise exec -- tuist generate --no-open

  fi
fi