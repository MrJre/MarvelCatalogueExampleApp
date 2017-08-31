//
//  CharacterListPresentationType.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 31/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

protocol CharacterListPresentationType: class {
    func present(characters: [MarvelCharacter])
    func present(error: Error)
}
