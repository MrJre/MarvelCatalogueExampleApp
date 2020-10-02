//
//  MarvelCharacterGateway.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 21/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

protocol CharacterGatewayType {
    func loadCharacters(completion: @escaping (Result<[MarvelCharacter], Error>) -> Void)
}

class CharacterWebGateway: CharacterGatewayType {

    private let httpService: HttpService
    private let authentication: Authentication

    init(httpService: HttpService, authentication: Authentication) {
        self.httpService = httpService
        self.authentication = authentication
    }

    func loadCharacters(completion: @escaping (Result<[MarvelCharacter], Error>) -> Void) {
        let urlString = "https://gateway.marvel.com/v1/public/characters"

        let privateKey = authentication.privateKey
        let publicKey = authentication.publicKey

        let timestamp = String(Date().timeIntervalSince1970)
        let hash = "\(timestamp)\(privateKey)\(publicKey)".MD5()

        let url = URL(string: urlString)!

        httpService.getObject(url: url, type: MarvelCharacterResponse.self, parameters: ["apikey": publicKey, "ts": timestamp, "hash": hash, "limit": "100"]) { (result) in
            switch result {
            case .success(let response):
                completion(.success(response.data.characters))
            case .failure(let error):
                print(error)
            }
        }
    }
}
