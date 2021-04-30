//
//  CharacterTableViewCell.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp on 30/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    private var thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .gray
        return view
    }()

    private var nameLabel: UILabel = {
        UILabel()
    }()

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8.0
        stackView.alignment = .center
        return stackView
    }()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        thumbnailImageView.image = nil
    }

    private func setupViews() {

        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        [thumbnailImageView, nameLabel].forEach { view in
            stackView.addArrangedSubview(view)
        }

        let constraints: [NSLayoutConstraint] = [
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),

            thumbnailImageView.heightAnchor.constraint(equalToConstant: 50.0),
            thumbnailImageView.widthAnchor.constraint(equalTo: thumbnailImageView.heightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}

extension CharacterTableViewCell: CharacterCellPresenting {

    func display(name: String) {
        nameLabel.text = name
    }

    func display(thumbnail: Data?) {
        if let thumbnail = thumbnail {
            thumbnailImageView.image = UIImage(data: thumbnail)
        } else {
            thumbnailImageView.image = nil
        }
    }
}
