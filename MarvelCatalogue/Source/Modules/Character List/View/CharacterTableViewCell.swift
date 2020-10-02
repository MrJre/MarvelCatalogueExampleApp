//
//  CharacterTableViewCell.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp on 30/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

}

extension CharacterTableViewCell: CharacterCellPresenting {

    func display(name: String) {
        textLabel?.text = name
    }

    func display(thumbnail: Data?) {
        if let thumbnail = thumbnail {
            imageView?.image = UIImage(data: thumbnail)
        } else {
            imageView?.image = nil
        }
    }
}
