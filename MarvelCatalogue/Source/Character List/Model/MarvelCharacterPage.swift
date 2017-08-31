//
//  MarvelCharacterPage.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 21/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

struct MarvelCharacterPage : Codable {
  
    let offset: Int
    let limit : Int
    let total : Int
    let count : Int
    let characters : [MarvelCharacter]
    
    enum CodingKeys : String, CodingKey {
        case characters = "results"
        case offset
        case limit
        case total
        case count
    }
}
