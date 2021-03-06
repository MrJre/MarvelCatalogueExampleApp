//
//  CharacterPresentationType.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp on 07/09/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import UIKit

protocol CharacterPresentationType: AnyObject {
    func present(imageData: Data)
    func present(error: Error)
}
