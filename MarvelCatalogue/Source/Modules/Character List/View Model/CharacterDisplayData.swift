//
//  CharacterDisplayData.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 02/10/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

struct CharacterDisplayData {

    let name: String
    let description: String
    var thumbnail: NSData?

    init(character: MarvelCharacter) {
        self.name = character.name
        self.description = character.description
    }
}
