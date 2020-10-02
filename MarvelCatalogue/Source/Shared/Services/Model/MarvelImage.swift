//
//  MarvelImage.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp on 02/10/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

struct MarvelImage: Codable {
    let path: URL
    let fileExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}
