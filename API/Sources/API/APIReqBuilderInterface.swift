//
//  APIReqBuilderInterface.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/12.
//

import Foundation
import Alamofire
import Resource
import Model

protocol APIReqBuilderInterface {
    var apiUrl: URL { get }
    var apiPath: String { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
    var httpHeader: HTTPHeaders { get }
    var timeout: TimeInterval { get }
}

extension APIReqBuilderInterface {

    var defaultHeader: HTTPHeaders {
        var headers: HTTPHeaders = [:]
        headers["X-GitHub-Api-Version"] = "2022-11-28"
        headers["Accept"] = "application/vnd.github+json"
        headers["Authorization"] = String(format: "Bearer %@", AccessToken.githubAPI.rawValue)
        return headers
    }

    var httpHeader: HTTPHeaders {
        defaultHeader
    }

    var encoding: ParameterEncoding {
        switch method {
        case .post, .put:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }

    var timeout: TimeInterval {
        TimeInterval(20)
    }

    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: self.apiUrl)
        request.httpMethod = self.method.rawValue
        self.httpHeader.forEach { header in
            request.setValue(header.value, forHTTPHeaderField: header.name)
        }
        request.timeoutInterval = timeout
        if let parameters = parameters {
            do {
                request = try encoding.encode(request, with: parameters)
            } catch {
                print("Failed in JSON encoding")
            }
        }
        return request
    }
}
