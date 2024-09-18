//
//  ProfileView.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/13.
//

import SwiftUI
import Model
import CommonView
import Router
import Stores
import UserView
import Repository

public struct ProfileView: View {
    @EnvironmentObject var rootRouter: RootRouter
    @EnvironmentObject var naviRouter: NavigationRouter
    @StateObject var userStore = UserStore()

    public init() {}

    public var body: some View {
        NavigationStack(path: $naviRouter.profilePath) {
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
                            ReposListChildView(repo: repo, pathContext: .profile)
                        }
                    }
                }
                Button("Logout") {
                    rootRouter.logout()
                }
                .frame(height: 50)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: ProfilePath.self) { path in
                switch path {
                case .repoWebView(let url):
                    ViewControllerRepresentable(url: url)
                }
            }
            .task {
//                guard let myName = UserDefaultRepository().loadLoginUser() else { return }
                await userStore.fetchUserAndReposByName(name: "mareiirie")
            }
            .alert(item: $userStore.userError) { alertData in
                Alert(title: Text(alertData.error.message()))
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(RootRouter.shared)
        .environmentObject(NavigationRouter.shared)
}
