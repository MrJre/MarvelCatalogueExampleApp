//
//  HttpService.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp on 21/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

enum HttpServiceError {
    case decodingError
}

class HttpService {

    let session: URLSession

    init(session: URLSession) {
        self.session = session
    }
    
    var requestStorage: [MarvelAPIRequest] = []
    
    func get(url: URL, parameters: [String: String]? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let finalUrl = construct(url: url, fromParameters: parameters) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let completion: (Data?, URLResponse?, Error?) -> Void = { (data, _, error) in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
            } else {
                // TODO: Something bad happened.
            }
        }
        
        run(url: finalUrl, completionHandler: completion)
    }

    func getObject<T: Decodable>(request: MarvelAPIRequest, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {

        guard !requestStorage.contains(request) else { return }
        
        guard let finalUrl = construct(url: request.url, fromParameters: request.parameters) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        let completion: (Data?, URLResponse?, Error?) -> Void = { (data, _, error) in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(T.self, from: data)
                    completion(.success(response))
                } catch let decodingError {
                    completion(.failure(decodingError))
                }
            } else if let error = error {
                completion(.failure(error))
            } else {
                // TODO: Something bad happened.
            }
            self.requestStorage.removeAll { $0 == request }
        }
        
        requestStorage.append(request)
        run(url: finalUrl, completionHandler: completion)
    }

    private func construct(url: URL, fromParameters parameters: [String: String]?) -> URL? {
        guard let parameters = parameters else { return url }

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)

        urlComponents?.queryItems = parameters.map { (kvPair) -> URLQueryItem in
            let escapedKey = kvPair.key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let escapedValue = kvPair.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return URLQueryItem(name: escapedKey, value: escapedValue)
        }

        return urlComponents?.url
    }
    
    private func run(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
         session.dataTask(with: url, completionHandler: completionHandler).resume()
    }
}
