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
    let gateway: CharacterGatewayType

    init(gateway: CharacterGatewayType) {
        self.gateway = gateway
    }

    func getCharacters() {
        gateway.loadCharacters { result in

            switch result {
            case .success(let characters):
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
}
