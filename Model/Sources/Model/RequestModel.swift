//
//  RequestModel.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/12.
//

import Foundation

public struct GetUsersQuery: Sendable {
    let per_page: Int?
}

public struct GetUsersReposQuery: Sendable {
    let type: String?
    let sort: String?
    let per_page: Int?
    let page: Int?
}
