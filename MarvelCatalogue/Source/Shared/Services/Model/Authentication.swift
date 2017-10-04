//
//  Authentication.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 04/10/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

struct Authentication: Codable {
    let privateKey: String
    let publicKey: String

    enum CodingKeys: String, CodingKey {
        case privateKey = "Private"
        case publicKey = "Public"
    }
}
