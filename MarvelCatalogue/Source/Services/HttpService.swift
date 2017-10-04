//
//  HttpService.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 21/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

class HttpService {

    let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func get(url: URL, parameters: [String:String], completion: @escaping (Result<Data>) -> Void) {

        guard let finalUrl = construct(url: url, fromParameters: parameters) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        print(finalUrl)

        let task = session.dataTask(with: finalUrl) { (data, _, error) in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
            } else {
                // TODO: Something bad happened.
            }
        }
        task.resume()
    }

    private func construct(url: URL, fromParameters parameters: [String:String]) -> URL? {

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)

        urlComponents?.queryItems = parameters.map { (kvPair) -> URLQueryItem in
            let escapedKey = kvPair.key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let escapedValue = kvPair.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return URLQueryItem(name: escapedKey, value: escapedValue)
        }

        return urlComponents?.url
    }
}
