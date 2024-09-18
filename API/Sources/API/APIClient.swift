//
//  APIClient.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/12.
//

import Foundation
import Model

// 本来はドメインごとに分けた方がいい
public struct API: Sendable {
    public var getUsers: @Sendable (_ query: GetUsersQuery?) async throws -> [UserModel]
    public var getUserByName: @Sendable (_ userName: String) async throws -> UserDetailModel
    public var getReposByUser: @Sendable (_ userName: String, _ query: GetUsersReposQuery?) async throws -> [RepositoryModel]
    public var checkUpdate: @Sendable () async throws -> UpdateModel
}

public extension API {
    static let value = Self(
        getUsers: { query -> [UserModel] in
            let request = APIReqBuilder.getUsers(query: query).asURLRequest()
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                let result = try StatusCodeHandler.handle(data: data, response: response)
                let decoded = try JSONDecoder().decode([UserModel].self, from: result)
                return decoded
            } catch {
                guard let appError = error as? AppErrorType else { throw AppErrorType.unknown }
                throw appError
            }
        },
        getUserByName: { userName -> UserDetailModel in
            let request = APIReqBuilder.getUserByName(userName: userName).asURLRequest()
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                let result = try StatusCodeHandler.handle(data: data, response: response)
                let decoded = try JSONDecoder().decode(UserDetailModel.self, from: result)
                return decoded
            } catch {
                guard let appError = error as? AppErrorType else { throw AppErrorType.unknown }
                throw appError
            }
        },
        getReposByUser: { userName, query -> [RepositoryModel] in
            let request = APIReqBuilder.getReposByUser(userName: userName, query: query).asURLRequest()
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                let result = try StatusCodeHandler.handle(data: data, response: response)
                let decoded = try JSONDecoder().decode([RepositoryModel].self, from: result)
                return decoded
            } catch {
                guard let appError = error as? AppErrorType else { throw AppErrorType.unknown }
                throw appError
            }
        },
        checkUpdate: { () -> UpdateModel in
            // 実際はここでアップデート情報などのチェックAPIが走る
            try await Task.sleep(for: .seconds(3))
            return UpdateModel(shouldUpdate: false)
        }
    )
}
