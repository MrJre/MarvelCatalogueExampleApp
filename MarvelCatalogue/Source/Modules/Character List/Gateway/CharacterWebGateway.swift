//
//  MarvelCharacterGateway.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 21/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

protocol CharacterGatewayType {
    func loadCharacters(completion: @escaping (Result<[MarvelCharacter]>) -> Void)
}

class CharacterWebGateway: CharacterGatewayType {

    private let httpService: HttpService
    private let authentication: Authentication

    init(httpService: HttpService, authentication: Authentication) {
        self.httpService = httpService
        self.authentication = authentication
    }

    func loadCharacters(completion: @escaping (Result<[MarvelCharacter]>) -> Void) {
        let urlString = "https://gateway.marvel.com/v1/public/characters"

        let privateKey = authentication.privateKey
        let publicKey = authentication.publicKey

        let ts = String(Date().timeIntervalSince1970)
        let hash = "\(ts)\(privateKey)\(publicKey)".MD5()

        let url = URL(string: urlString)!

        httpService.get(url: url, parameters: ["apikey": publicKey, "ts": ts, "hash": hash, "limit": "100"]) { (result) in
            switch result {
            case .success(let data):
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(MarvelCharacterResponse.self, from: data)
                    completion(.success(response.data.characters))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
