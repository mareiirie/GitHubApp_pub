//
//  ErrorModel.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/12.
//

import Foundation

public struct AppError: Identifiable {
    public let id = UUID()
    public let error: AppErrorType

    public init(error: AppErrorType) {
        self.error = error
    }
}

public enum AppErrorType: Error {
    case unknownStatusCode
    case decode
    case resourceNotFound
    case unknown

    public func message () -> String {
        switch self {
        case .unknownStatusCode:
            return "Unknown StatusCode Error"
        case .decode:
            return "Decode Error"
        case .resourceNotFound:
            return "Resource Not Found"
        case .unknown:
            return "Unknwon Error"
        }
    }
}
