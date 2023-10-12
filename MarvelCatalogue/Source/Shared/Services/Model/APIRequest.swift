//
// Created by Jerry Tromp on 28/05/2021.
// Copyright (c) 2021 Jerry Tromp. All rights reserved.
//

import Foundation

protocol APIRequest {
    var url: URL { get }
    var parameters: [String: String] { get }
}

struct MarvelAPIRequest: APIRequest {
    
    var url: URL
    var offset: Int
    
    var apiKey: String
    var timestamp: String
    var hash: String
    
    var parameters: [String : String] { ["apikey": apiKey, "ts": timestamp, "hash": hash, "limit": "100", "offset": "\(offset)"] }
}

extension MarvelAPIRequest: Equatable {
    static func == (lhs: MarvelAPIRequest, rhs: MarvelAPIRequest) -> Bool {
        return lhs.url == rhs.url && lhs.offset == rhs.offset
    }
}

extension MarvelAPIRequest {
    static func getCharacters(apiKey: String, timestamp: String, hash: String, offset: Int) -> MarvelAPIRequest {
        let url = URL(string: "https://gateway.marvel.com/v1/public/characters")!
        
        return MarvelAPIRequest(url: url, offset: offset, apiKey: apiKey, timestamp: timestamp, hash: hash)
    }
}
