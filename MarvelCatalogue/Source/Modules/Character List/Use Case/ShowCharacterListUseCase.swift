//
//  ShowCharacterListUseCase.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 30/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

class ShowCharacterListUseCase {

    weak var presenter: CharacterListPresentationType?
    let characterGateway: CharacterGatewayType
    let imageGateway: CharacterImageGatewayType

    private var characters: [MarvelCharacter]?

    init(characterGateway: CharacterGatewayType, imageGateway: CharacterImageGatewayType) {
        self.characterGateway = characterGateway
        self.imageGateway = imageGateway
    }

    func getCharacters() {
        characterGateway.loadCharacters { result in

            switch result {
            case .success(let characters):
                self.characters = characters

                let characterDisplayData = characters.map({ (character) -> CharacterDisplayData in
                    CharacterDisplayData(character: character)
                })

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
        guard let character = characters?[index] else { return }
        getThumbnail(for: character)
    }

    private func getThumbnail(for character: MarvelCharacter) {
        imageGateway.loadCharacterImage(for: character) { (result) in
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
