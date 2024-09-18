//
//  UserStoreTests.swift
//  UserStoreTests
//
//  Created by marei_irie on 2024/09/12.
//

import XCTest
import API
import Model
import Stores

final class UserStoreTests: XCTestCase {

    /*
     fetchUserAndReposByName時に、isForkedなデータが除かれることを確認するテスト
    */
    @MainActor
    func test_1() throws {
        let userStore = UserStore()
        userStore.api.getReposByUser = { _, _ in return MockRepositoryResponse.mock }
        userStore.api.getUserByName = {_ in MockUserResponse.mock }
        Task {
            await userStore.fetchUserAndReposByName(name: "")
            let expected = [RepositoryModel(id: 1,
                                           fullName: "",
                                           description: "",
                                           isForked: false,
                                           language: "",
                                           stargazersCount: 1,
                                           repoUrl: URL(string: "https://www.google.co.jp")!
                                          )
                            ]
            XCTAssertEqual(userStore.userWithRepos?.repos, expected)
        }
    }

    /*
     fetchUserByNameがエラーだった場合、適切なエラーが返るテスト
    */
    @MainActor
    func test_2() throws {
        let userStore = UserStore()
        userStore.api.getUserByName = {_ in throw AppErrorType.resourceNotFound }
        Task {
            await userStore.fetchUserByName(name: "")
            let expected = AppErrorType.resourceNotFound
            XCTAssertEqual(userStore.userWithRepos, nil)
            XCTAssertEqual(userStore.userError?.error, expected)
        }
    }
}
