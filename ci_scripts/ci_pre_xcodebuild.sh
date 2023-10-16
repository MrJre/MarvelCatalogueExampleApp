#!/bin/sh

#  ci_pre_xcodebuild.sh
#  MarvelCatalogue
#
#  Created by Jerry Tromp on 16/10/2023.
#  Copyright © 2023 Jerry Tromp. All rights reserved.

add_credentials_to_plist() {
    echo 'Adding credentials to plist'
    /usr/libexec/PlistBuddy -c "clear dict" -c "Add :public string $marvel_public_key" -c "Add :private string $marvel_private_key" '../MarvelCatalogue/Supporting Files/MarvelCredentials.plist'
    return 0
}

add_credentials_to_plist
