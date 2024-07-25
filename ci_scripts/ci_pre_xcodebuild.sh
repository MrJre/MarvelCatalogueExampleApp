#!/bin/sh

#  ci_prebuild.sh
#  MarvelCatalogue
#
#  Created by Jerry Tromp on 18/10/2023.
#  Copyright © 2023 Jerry Tromp. All rights reserved.

add_credentials_to_plist() {
    echo 'Adding credentials to plist'
    env
    /usr/libexec/PlistBuddy -c "clear dict" -c "Add :public string $marvel_public_key" -c "Add :private string $marvel_private_key" '../MarvelCatalogue/Supporting Files/MarvelCredentials.plist'
    plutil -convert binary1 '../MarvelCatalogue/Supporting Files/MarvelCredentials.plist'
    return 0
}

add_credentials_to_plist
