#!/bin/sh

#  ci_post_clone.sh
#  MarvelCatalogue
#
#  Created by Jerry Tromp on 16/10/2023.
#  Copyright © 2023 Jerry Tromp. All rights reserved.

install_or_update_swiftlint_if_needed() {
    echo "\nInstalling or updating SwiftLint if needed"
    brew install swiftlint
    return 0
}

install_or_update_swiftlint_if_needed
