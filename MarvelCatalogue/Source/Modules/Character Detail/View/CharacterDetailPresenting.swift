//
//  CharacterPresenting.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 07/09/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

protocol CharacterDetailPresenting: class {
    func display(imageData: Data)
    func display(error: Error)
}
