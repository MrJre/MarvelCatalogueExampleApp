//
//  CharacterListPresenting.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp on 30/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

protocol CharacterListPresenting: AnyObject {
    func refreshData()
    func updateData(at index: Int)
}
