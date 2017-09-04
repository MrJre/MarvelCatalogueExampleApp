//
//  MarvelCharacterGateway.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 21/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

protocol CharacterGatewayType {
    func getCharacters(completion: @escaping (Result<[MarvelCharacter]>) -> Void)
}

class CharacterWebGateway: CharacterGatewayType {

    let httpService: HttpService

    init(httpService: HttpService) {
        self.httpService = httpService
    }

    func getCharacters(completion: @escaping (Result<[MarvelCharacter]>) -> Void) {
        let urlString = "https://gateway.marvel.com/v1/public/characters"
        let publicKey = "***REMOVED***"
        let privateKey = "***REMOVED***"
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(string: "\(ts)\(privateKey)\(publicKey)")

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

    func MD5(string: String) -> String {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))

        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }

        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
}
