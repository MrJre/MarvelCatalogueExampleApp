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
        gateway.getCharacters { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    self.presenter?.present(characters: characters)
                case .failure(let error):
                    self.presenter?.present(error: error)
                }
            }
        }
    }
}
