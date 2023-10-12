//
//  ShowCharacterListUseCase.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp on 30/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

class ShowCharacterListUseCase {

    weak var presenter: CharacterListPresentationType?
    let characterGateway: CharacterGatewayType
    let imageGateway: CharacterImageGatewayType

    var characters: [MarvelCharacter] = []

    init(characterGateway: CharacterGatewayType, imageGateway: CharacterImageGatewayType) {
        self.characterGateway = characterGateway
        self.imageGateway = imageGateway
    }

    func getCharacters() {
        characterGateway.loadCharacters(offset: characters.count) { result in

            switch result {
            case .success(let characters):
                self.characters.append(contentsOf: characters)

                    let characterDisplayData = self.characters.map {
                    CharacterDisplayData(character: $0)
                }

                DispatchQueue.main.async {
                    self.presenter?.present(characters: characterDisplayData)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presenter?.present(error: error)
                }
            }
        }
    }

    func getThumbnailForCharacter(at index: Int) {
        getThumbnail(for: characters[index])
    }

    private func getThumbnail(for character: MarvelCharacter) {
        imageGateway.load(image: character.thumbnail, type: .standard) { result in
            switch result {
            case .success(let imageData):

                var character = CharacterDisplayData(character: character)
                character.thumbnail = imageData

                DispatchQueue.main.async {
                    self.presenter?.update(character: character)
                }

            case .failure(let error):
                print("not found: \(error)")
            }
        }
    }
}
