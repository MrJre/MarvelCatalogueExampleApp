//
//  CharacterDetailViewController.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 07/09/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    @IBOutlet weak var characterImageView: UIImageView!

    var characterPresenter: CharacterPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CharacterDetailViewController: CharacterDetailPresenting {
    func display(imageData: Data) {
        characterImageView.image = UIImage(data: imageData)
    }

    func display(error: Error) {
        
    }
}
