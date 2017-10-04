//
//  CharacterImageWebGateway.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 02/10/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

protocol CharacterImageGatewayType {
    func loadCharacterImage(for character: MarvelCharacter, completion: @escaping (Result<Data>) -> Void)
}

class CharacterImageWebGateway: CharacterImageGatewayType {

    private let httpService: HttpService
    private var charactersDownloading: Set<MarvelCharacter> = []

    init(httpService: HttpService) {
        self.httpService = httpService
    }

    func loadCharacterImage(for character: MarvelCharacter, completion: @escaping (Result<Data>) -> Void) {
        guard !charactersDownloading.contains(character) else { return }
        charactersDownloading.insert(character)

        let thumbnail = character.thumbnail

        var components = URLComponents(url: thumbnail.path, resolvingAgainstBaseURL: false)
        components?.scheme = "https"

        var url = components?.url
        url?.appendPathComponent("standard_medium")
        url?.appendPathExtension(thumbnail.fileExtension)

        httpService.get(url: url!) { (result) in
             completion(result)
        }
    }
}
