//
//  AuthenticationRepository.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp on 12/10/2023.
//  Copyright © 2023 Jerry Tromp. All rights reserved.
//

import Foundation

private enum AuthenticationKeys: String {
    // swiftlint:disable:next identifier_name
    case marvel_public_key
    // swiftlint:disable:next identifier_name
    case marvel_private_key
}

struct AuthenticationRepository {
    func loadAuthentication() -> Authentication? {
        if let credentialsUrl = Bundle.main.url(forResource: "MarvelCredentials", withExtension: "plist") {
            do {
                let credentialsData = try Data(contentsOf: credentialsUrl)
                return try PropertyListDecoder().decode(Authentication.self, from: credentialsData)
            } catch {
                print(error)
                return nil
            }
        } else if let publicKey = ProcessInfo.processInfo.environment[AuthenticationKeys.marvel_public_key.rawValue],
                  let privateKey = ProcessInfo.processInfo.environment[AuthenticationKeys.marvel_private_key.rawValue] {
            return Authentication(privateKey: privateKey, publicKey: publicKey)
        }

        return nil
    }
}
