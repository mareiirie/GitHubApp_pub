//
//  Mock.swift
//  GithubAppTests
//
//  Created by marei_irie on 2024/09/13.
//

import Foundation
import Model

enum MockRepositoryResponse {
    static let mock = [RepositoryModel(id: 1,
                                       fullName: "",
                                       description: "",
                                       isForked: true,
                                       language: "",
                                       stargazersCount: 1,
                                       repoUrl: URL(string: "https://www.google.co.jp")!
                                      ),
                       RepositoryModel(id: 1,
                                       fullName: "",
                                       description: "",
                                       isForked: false,
                                       language: "",
                                       stargazersCount: 1,
                                       repoUrl: URL(string: "https://www.google.co.jp")!
                                      )
    ]
}

enum MockUserResponse {
    static let mock = UserDetailModel(id: 1,
                                      name: "",
                                      avatarUrl: URL(string: "https://www.google.co.jp")!,
                                      followersCount: 1,
                                      followingCount: 1,
                                      fullName: "")
}
