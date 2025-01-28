#!/bin/sh

#  ci_post_clone.sh
#  
#
#  Created by Bonsung Koo on 28/01/2025.
#  

curl https://mise.jdx.dev/install.sh | sh
mise install # Installs the version from .mise.toml

mise exec -- TUIST_DEVELOPMENT_TEAM=$DEVELOPMENT_TEAM tuist generate --no-open
