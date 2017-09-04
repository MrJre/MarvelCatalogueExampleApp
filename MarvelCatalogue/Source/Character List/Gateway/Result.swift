//
//  Result.swift
//  MarvelCatalogue
//
//  Created by Jerry Tromp | The Mobile Company on 21/08/2017.
//  Copyright © 2017 Jerry Tromp. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)

    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }

    public var isFailure: Bool {
        return !isSuccess
    }

    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }

    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}
