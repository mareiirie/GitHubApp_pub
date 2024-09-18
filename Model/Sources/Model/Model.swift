//
//  Model.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/12.
//

import Foundation

// publicがつく場合は明示的にSendableをつけないといけない
public struct UserModel: Identifiable, Equatable, Decodable, Sendable {
    public let id: Int
    public let userName: String
    public let avatarUrl: URL
    // 通常はResponseにある想定。本当にない場合、Protocolにするか、ResponseModelとApp内のModelを切り分ける
    public var isFavourite: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case userName = "login"
        case avatarUrl = "avatar_url"
      }
}

public struct UserDetailModel: Identifiable, Equatable, Decodable, Sendable {
    public let id: Int
    public let name: String
    public let avatarUrl: URL
    public let followersCount: Int
    public let followingCount: Int
    public let fullName: String?

    public init(id: Int,
                name: String,
                avatarUrl: URL,
                followersCount: Int,
                followingCount: Int,
                fullName: String?) {
        self.id = id
        self.name = name
        self.avatarUrl = avatarUrl
        self.followersCount = followersCount
        self.followingCount = followingCount
        self.fullName = fullName
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name = "login"
        case avatarUrl = "avatar_url"
        case followersCount = "followers"
        case followingCount = "following"
        case fullName = "name"
    }
}

public struct RepositoryModel: Identifiable, Equatable, Decodable, Sendable {
    public let id: Int
    public let fullName: String
    public let description: String?
    public let isForked: Bool
    public let language: String?
    public let stargazersCount: Int
    public let repoUrl: URL

    public init(id: Int,
                fullName: String,
                description: String?,
                isForked: Bool,
                language: String?,
                stargazersCount: Int,
                repoUrl: URL) {
        self.id = id
        self.fullName = fullName
        self.description = description
        self.isForked = isForked
        self.language = language
        self.stargazersCount = stargazersCount
        self.repoUrl = repoUrl
    }

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case description
        case isForked = "fork"
        case language = "followers"
        case stargazersCount = "stargazers_count"
        case repoUrl = "html_url"
    }
}

public struct UpdateModel: Sendable{
    public let shouldUpdate: Bool

    public init(shouldUpdate: Bool) {
        self.shouldUpdate = shouldUpdate
    }
}

public struct UserDetailWithReposModel: Equatable, Sendable {
    public let user: UserDetailModel
    public let repos: [RepositoryModel]

    public init(user: UserDetailModel, repos: [RepositoryModel]) {
        self.user = user
        self.repos = repos
    }
}
