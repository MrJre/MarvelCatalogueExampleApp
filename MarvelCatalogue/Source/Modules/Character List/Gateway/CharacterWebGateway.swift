//
//  MarvelCharacterGateway.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp on 21/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

protocol CharacterGatewayType {
    func loadCharacters(offset: Int, completion: @escaping (Result<[MarvelCharacter], Error>) -> Void)
}

class CharacterWebGateway: CharacterGatewayType {

    private let httpService: HttpService
    private let authentication: Authentication

    init(httpService: HttpService, authentication: Authentication) {
        self.httpService = httpService
        self.authentication = authentication
    }

    func loadCharacters(offset: Int, completion: @escaping (Result<[MarvelCharacter], Error>) -> Void) {
        let privateKey = authentication.privateKey
        let publicKey = authentication.publicKey

        let timestamp = String(Date().timeIntervalSince1970)
        let hash = "\(timestamp)\(privateKey)\(publicKey)".MD5()
        
        let request = MarvelAPIRequest.getCharacters(apiKey: publicKey, timestamp: timestamp, hash: hash, offset: offset)
        
        httpService.getObject(request: request, type: MarvelCharacterResponse.self) { result in
            switch result {
            case .success(let response):
                    let result = response.data.characters
                    print(result.count)
                completion(.success(result))
            case .failure(let error):
                print(error)
            }
        }
    }
}
