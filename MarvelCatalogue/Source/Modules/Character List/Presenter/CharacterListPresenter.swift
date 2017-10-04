//
//  CharacterListPresenter.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 30/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

class CharacterListPresenter {

    let useCase: ShowCharacterListUseCase
    weak var view: CharacterListPresenting?

    private var characters = [CharacterDisplayData]()

    init(useCase: ShowCharacterListUseCase) {
        self.useCase = useCase
    }

    func getCharacters() {
        useCase.getCharacters()
    }

    func getCharacterCount() -> Int {
        return characters.count
    }

    func configure(view: CharacterCellPresenting, at index: Int) {
        let character = characters[index]
        view.display(name: character.name)
        view.display(thumbnail: character.thumbnail)
    }
}

extension CharacterListPresenter : CharacterListPresentationType {

    func present(characters: [CharacterDisplayData]) {
        self.characters = characters
        view?.refreshData()
    }

    func present(error: Error) {
        print(error)
    }
}
