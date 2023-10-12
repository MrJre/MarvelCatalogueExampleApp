//
//  CharacterListCoordinator.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp on 04/09/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import UIKit

class CharacterListCoordinator: Coordinating {

    var viewController: CharacterListViewController?
    var useCase: ShowCharacterListUseCase?
    let root: UIViewController

    init(root: UIViewController) {
        self.root = root
    }

    func createViewController() -> CharacterListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let characterListViewController = storyboard.instantiateInitialViewController() as? CharacterListViewController else { fatalError() }
        guard let authentication = AuthenticationRepository().loadAuthentication() else { fatalError() }

        let httpService = HttpService(session: URLSession.shared)
        let characterGateway = CharacterWebGateway(httpService: httpService, authentication: authentication)
        let characterImageGateway = CharacterImageWebGateway(httpService: httpService)

        useCase = ShowCharacterListUseCase(characterGateway: characterGateway, imageGateway: characterImageGateway)
        let characterPresenter = CharacterListPresenter(useCase: useCase!)

        characterPresenter.coordinator = self
        characterPresenter.view = characterListViewController
        useCase?.presenter = characterPresenter
        characterListViewController.presenter = characterPresenter

        return characterListViewController
    }
}

extension CharacterListCoordinator: CharacterListCoordinationType {
    func show(characterAt index: Int) {
        guard let viewController = viewController else { return }
        guard let character = useCase?.characters[index] else { return }

        let characterDetailCoordinator = CharacterDetailCoordinator(root: viewController, character: character)
        characterDetailCoordinator.start()
    }
}
