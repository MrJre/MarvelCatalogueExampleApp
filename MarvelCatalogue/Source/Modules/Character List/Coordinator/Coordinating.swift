//
//  Coordinator.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 04/09/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import UIKit

protocol Coordinating: class {
    associatedtype ViewController: UIViewController
    var viewController: ViewController? { get set }
    var root: UIViewController { get }
    func createViewController() -> ViewController
    func configure(viewController: ViewController)
    func show(viewController: ViewController)
    func dismiss()
}

extension Coordinating {
    func configure(viewController: ViewController) {}

    func show(viewController: ViewController) {
        root.show(viewController, sender: self)
    }

    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}

extension Coordinating {
    func start() {
        let viewController = createViewController()
        configure(viewController: viewController)
        show(viewController: viewController)
        self.viewController = viewController
    }

    func stop() {
        dismiss()
        self.viewController = nil
    }
}
