//
//  CharacterDisplayData.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp on 02/10/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

struct CharacterDisplayData {

    let name: String
    let description: String
    var thumbnail: Data?

    init(character: MarvelCharacter) {
        name = character.name
        description = character.description
    }
}
