//
//  Authentication.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp on 04/10/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

struct Authentication: Codable {
    let privateKey: String
    let publicKey: String

    init(privateKey: String, publicKey: String) {
        self.privateKey = privateKey
        self.publicKey = publicKey
    }

    enum CodingKeys: String, CodingKey {
        case privateKey = "Private"
        case publicKey = "Public"
    }
}
