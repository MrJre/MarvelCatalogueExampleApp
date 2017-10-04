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
        guard let authentication = loadAuthentication() else { fatalError() }

        let httpService = HttpService(session: URLSession.shared)
        let characterGateway = CharacterWebGateway(httpService: httpService, authentication: authentication)
        let characterImageGateway = CharacterImageWebGateway(httpService: httpService)

        let characterUseCase = ShowCharacterListUseCase(characterGateway: characterGateway, imageGateway: characterImageGateway)
        let characterPresenter = CharacterListPresenter(useCase: characterUseCase)

        characterPresenter.view = characterListViewController
        characterUseCase.presenter = characterPresenter
        characterListViewController.presenter = characterPresenter

        return characterListViewController
    }

    private func loadAuthentication() -> Authentication? {
        guard let credentialsUrl = Bundle.main.url(forResource: "MarvelCredentials", withExtension: "plist") else { return nil }
        do {
            let credentialsData = try Data(contentsOf: credentialsUrl)
            return try PropertyListDecoder().decode(Authentication.self, from: credentialsData)
        } catch {
            print(error)
            return nil
        }
    }
}
