//
//  CharacterImageWebGateway.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 02/10/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

protocol CharacterImageGatewayType {
    func loadCharacterImage(for character: MarvelCharacter, completion: @escaping (Result<[Data]>) -> Void)
}

class CharacterImageWebGateway: CharacterImageGatewayType {

    private let httpService: HttpService

    init(httpService: HttpService) {
        self.httpService = httpService
    }

    func loadCharacterImage(for character: MarvelCharacter, completion: @escaping (Result<[Data]>) -> Void) {
        let publicKey = "***REMOVED***"
        let privateKey = "***REMOVED***"
        let ts = String(Date().timeIntervalSince1970)
        let hash = "\(ts)\(privateKey)\(publicKey)".MD5()

        let urlString = character.thumbnail.path
        print(urlString)
//        let url = URL(string: urlString)!
    }
}
