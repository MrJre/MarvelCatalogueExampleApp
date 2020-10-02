//
//  ViewController.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp on 21/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import UIKit

class CharacterListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var presenter: CharacterListPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterCell")

        presenter.getCharacters()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CharacterListViewController: CharacterListPresenting {
    func refreshData() {
        tableView.reloadData()
    }

    func updateData(at index: Int) {
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }
}

extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showCharacterDetail(for: indexPath.row)
    }
}

extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getCharacterCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? CharacterTableViewCell else {
            fatalError()
        }

        presenter.configure(view: cell, at: indexPath.row)

        return cell
    }
}
