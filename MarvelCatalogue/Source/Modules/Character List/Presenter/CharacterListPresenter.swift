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
    weak var coordinator: CharacterListCoordinationType?

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

        if character.thumbnail == nil {
            useCase.getThumbnailForCharacter(at: index)
        }
    }

    func showCharacterDetail(for index: Int) {
        coordinator?.show(characterAt: index)
    }
}

extension CharacterListPresenter : CharacterListPresentationType {

    func present(characters: [CharacterDisplayData]) {
        self.characters = characters
        view?.refreshData()
    }

    func update(character: CharacterDisplayData) {
        guard let index = characters.index(where: { $0.name == character.name }) else { return }
        characters[index] = character
        view?.updateData(at: index)
    }

    func present(error: Error) {
        print(error)
    }
}
