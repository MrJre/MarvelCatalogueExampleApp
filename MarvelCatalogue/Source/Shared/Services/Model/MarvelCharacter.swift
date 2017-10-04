//
//  MarvelCharacter.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 21/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

struct MarvelCharacter: Codable {
    let name: String
    let description: String
    let thumbnail: MarvelImage
}
