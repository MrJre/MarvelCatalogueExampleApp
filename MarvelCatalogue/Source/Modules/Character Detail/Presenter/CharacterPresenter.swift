//
//  CharacterPresenter.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 07/09/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

class CharacterPresenter {
    weak var view: CharacterDetailPresenting?
    let useCase: ShowCharacterDetailUseCase

    init(useCase: ShowCharacterDetailUseCase) {
        self.useCase = useCase
    }
}

extension CharacterPresenter: CharacterPresentationType {
    func present(imageData: Data) {
        view?.display(imageData: imageData)
    }

    func present(error: Error) {
        view?.display(error: error)
    }
}
