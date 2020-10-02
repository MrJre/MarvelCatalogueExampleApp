//
//  CharacterDetailCoordinator.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp on 04/10/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import UIKit

class CharacterDetailCoordinator: Coordinating {
    var viewController: CharacterDetailViewController?
    var root: UIViewController

    private let character: MarvelCharacter

    init(root: UIViewController, character: MarvelCharacter) {
        self.root = root
        self.character = character
    }

    func createViewController() -> CharacterDetailViewController {
        let storyboard = UIStoryboard(name: "CharacterDetail", bundle: nil)
        guard let view = storyboard.instantiateInitialViewController() as? CharacterDetailViewController else { fatalError() }

        let httpService = HttpService(session: URLSession.shared)
        let imageGateway = CharacterImageWebGateway(httpService: httpService)
        let useCase = ShowCharacterDetailUseCase(imageGateway: imageGateway, character: character)

        let presenter = CharacterPresenter(useCase: useCase)

        view.characterPresenter = presenter
        presenter.view = view

        useCase.presenter = presenter

        return view
    }
}
