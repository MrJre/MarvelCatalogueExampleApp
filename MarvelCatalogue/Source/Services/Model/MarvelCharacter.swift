//
//  MarvelCharacter.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 21/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

struct MarvelCharacter: Codable {
    let identifier: Int
    let name: String
    let description: String
    let thumbnail: MarvelImage

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case description
        case thumbnail
    }
}

extension MarvelCharacter: Hashable {
    var hashValue: Int {
        return identifier
    }

    static func == (lhs: MarvelCharacter, rhs: MarvelCharacter) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
