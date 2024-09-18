//
//  StatusCodeHandler.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/12.
//

import Foundation
import Model

public enum StatusCodeHandler {
    static func handle(data: Data, response: URLResponse) throws -> Data {
        let statusCode = (response as? HTTPURLResponse)?.statusCode
        switch statusCode {
        case .some(let code) where (200..<400).contains(code):
            return data
        case 404:
            throw AppErrorType.resourceNotFound
        default:
            throw AppErrorType.unknownStatusCode
        }
    }
}
