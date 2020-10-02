//
//  CharacterListPresentationType.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp on 31/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

protocol CharacterListPresentationType: class {
    func present(characters: [CharacterDisplayData])

    func update(character: CharacterDisplayData)

    func present(error: Error)
}
