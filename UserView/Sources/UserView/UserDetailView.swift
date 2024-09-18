//
//  UserDetailView.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/13.
//

import SwiftUI
import Model
import CommonView
import Router
import Stores

public struct UserDetailView: View {
    // EnvironmentObjectにすると生存期間が長すぎて、前回の状態が残ってしまいちらつきなどが発生する
    @StateObject var userStore = UserStore()

    let name: String

    public init(name: String) {
        self.name = name
    }

    public var body: some View {
        VStack {
            LoadingView(isLoading: $userStore.isLoading)
            if let userWithRepos = userStore.userWithRepos {
                Section(header: UserProfileView(userName: userWithRepos.user.name,
                                                avatarUrl: userWithRepos.user.avatarUrl,
                                                fullName: userWithRepos.user.fullName,
                                                followersCount: userWithRepos.user.followersCount,
                                                followingCount: userWithRepos.user.followingCount
                                               )
                ){
                    List(userWithRepos.repos) { repo in
                        ReposListChildView(repo: repo, pathContext: .user)
                    }
                }
            }
        }
        .task {
            await userStore.fetchUserAndReposByName(name: name)
        }
        .alert(item: $userStore.userError) { alertData in
            Alert(title: Text(alertData.error.message()))
        }
    }
}

public struct ReposListChildView: View {
    @EnvironmentObject var naviRouter: NavigationRouter
    let repo: RepositoryModel
    let pathContext: PathContext

    public init(repo: RepositoryModel, pathContext: PathContext) {
        self.repo = repo
        self.pathContext = pathContext
    }

    public var body: some View {
        VStack {
            HStack {
                Button(repo.fullName) {
                    switch pathContext {
                    case .user:
                        naviRouter.pushUser(.repoWebView(url: repo.repoUrl))
                    case .favourite:
                        naviRouter.pushFavourite(.repoWebView(url: repo.repoUrl))
                    case .profile:
                        naviRouter.pushProfile(.repoWebView(url: repo.repoUrl))
                    }
                }
                Spacer()
                HStack {
                    Image(systemName: "star")
                    Text(String(repo.stargazersCount))
                }
            }
            if let language = repo.language {
                Text(language)
            }
            if let description = repo.description {
                Text(description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
            }
        }
    }
}

#Preview {
    UserDetailView(name: "mareiirie")
        .environmentObject(RootRouter.shared)
        .environmentObject(NavigationRouter.shared)
}
