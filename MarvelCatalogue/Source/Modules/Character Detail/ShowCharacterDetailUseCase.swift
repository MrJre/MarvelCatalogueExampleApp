//
//  ShowCharacterDetailUseCase.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 07/09/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

class ShowCharacterDetailUseCase {

    weak var presenter: CharacterPresentationType?
    let character: MarvelCharacter
    let imageGateway: CharacterImageGatewayType

    init(imageGateway: CharacterImageGatewayType, character: MarvelCharacter) {
        self.imageGateway = imageGateway
        self.character = character
    }

    func getImage() {
        imageGateway.loadCharacterImage(for: character) { (result) in

            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.presenter?.present(imageData: data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presenter?.present(error: error)
                }
            }
        }
    }
}
