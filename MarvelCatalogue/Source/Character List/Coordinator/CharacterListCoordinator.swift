//
//  CharacterListCoordinator.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 04/09/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import UIKit

class CharacterListCoordinator: Coordinating {

    var viewController: CharacterListViewController?
    let root: UIViewController

    init(root: UIViewController) {
        self.root = root
    }

    func createViewController() -> CharacterListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let characterListViewController = storyboard.instantiateInitialViewController() as? CharacterListViewController else { fatalError() }

        let characterGateway = CharacterWebGateway(httpService: HttpService(session: URLSession.shared))
        let characterUseCase = ShowCharacterListUseCase(gateway: characterGateway)
        let characterPresenter = CharacterListPresenter(useCase: characterUseCase)

        characterPresenter.view = characterListViewController
        characterUseCase.presenter = characterPresenter
        characterListViewController.presenter = characterPresenter

        return characterListViewController
    }
}
