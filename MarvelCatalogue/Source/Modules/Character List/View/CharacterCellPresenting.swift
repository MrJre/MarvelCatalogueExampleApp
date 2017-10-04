//
//  CharacterPresenting.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 30/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

protocol CharacterCellPresenting {
    func display(name: String)
    func display(thumbnail: Data?)
}
