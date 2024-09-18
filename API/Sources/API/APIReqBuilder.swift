//
//  APIReqBuilder.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/12.
//

import Foundation
import Resource
import Alamofire
import Model

/// ***
/// - [list-repositories-for-a-user](https://docs.github.com/ja/rest/repos/repos?apiVersion=2022-11-28#list-repositories-for-a-user)
/// - [list-users](https://docs.github.com/ja/rest/users/users?apiVersion=2022-11-28#list-users)
/// ***
public enum APIReqBuilder: APIReqBuilderInterface {

    case getUsers(query: GetUsersQuery?)
    case getUserByName(userName: String)
    case getReposByUser(userName: String, query: GetUsersReposQuery?)

    var apiUrl: URL {
        URL(string: BaseURL.githubBaseURL.rawValue + apiPath)!
    }

    var apiPath: String {
        switch self {
        case .getUsers:
            return "/users"
        case .getUserByName(let userName):
            return "/users/\(userName)"
        case .getReposByUser(let userName, _):
            return "/users/\(userName)/repos"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .getUsers(_):
            return nil
        case .getUserByName:
            return nil
        case .getReposByUser(_, _):
            return nil
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getUsers, .getUserByName, .getReposByUser:
            return .get
        }
    }
}
