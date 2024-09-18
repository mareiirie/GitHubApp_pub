//
//  UserStore.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/13.
//

import Foundation
import API
import Model

@MainActor
public final class UserStore: ObservableObject {
    @Published public var userWithRepos: UserDetailWithReposModel?
    @Published public var user: UserDetailModel?
    @Published public var userError: AppError?
    @Published public var isLoading = false
    public var api = API.value

    public init() {}

    @MainActor
    public func fetchUserAndReposByName(name: String) async {
        isLoading = true
        do {
            async let user = try await api.getUserByName(name)
            async let repos = try await api.getReposByUser(name, nil)
            var reposFiltered = try await (user: user, repos: repos)
            reposFiltered.1.removeAll(where: { $0.isForked })
            let userWithRepos = UserDetailWithReposModel(user: reposFiltered.user,
                                                         repos: reposFiltered.repos)
            self.userWithRepos = userWithRepos
            print("\(userWithRepos)")
        } catch {
            guard let errorType = error as? AppErrorType else { return }
            self.userError = AppError(error: errorType)
        }
        isLoading = false
    }

    @MainActor
    public func fetchUserByName(name: String) async {
        isLoading = true
        do {
            let user = try await api.getUserByName(name)
            self.user = user
            print("\(user)")
        } catch {
            guard let errorType = error as? AppErrorType else { return }
            self.userError = AppError(error: errorType)
        }
        isLoading = false
    }
}
