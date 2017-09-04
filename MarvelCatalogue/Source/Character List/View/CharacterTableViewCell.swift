//
//  CharacterTableViewCell.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 30/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

}

extension CharacterTableViewCell : CharacterPresenting {
    func display(name: String) {
        textLabel?.text = name
    }
}
