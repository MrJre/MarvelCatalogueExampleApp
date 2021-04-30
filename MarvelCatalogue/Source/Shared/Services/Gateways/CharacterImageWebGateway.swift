//
//  CharacterImageWebGateway.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp on 02/10/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

protocol CharacterImageGatewayType {
    func load(image: MarvelImage, type: ImageType, completion: @escaping (Result<Data, Error>) -> Void)
}

class CharacterImageWebGateway: CharacterImageGatewayType {

    private let httpService: HttpService
    private var imagesDownloading: Set<String> = []

    init(httpService: HttpService) {
        self.httpService = httpService
    }

    func load(image: MarvelImage, type: ImageType, completion: @escaping (Result<Data, Error>) -> Void) {
        guard !imagesDownloading.contains(image.path.lastPathComponent) else { return }
        imagesDownloading.insert(image.path.lastPathComponent)

        var components = URLComponents(url: image.path, resolvingAgainstBaseURL: false)
        components?.scheme = "https"

        var url = components?.url
        url?.appendPathComponent(type.rawValue)
        url?.appendPathExtension(image.fileExtension)

        httpService.get(url: url!) { result in
            completion(result)
            self.imagesDownloading.remove(image.path.lastPathComponent)
        }
    }
}
