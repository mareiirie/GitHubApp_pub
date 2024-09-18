//
//  UserView.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/13.
//

import SwiftUI
import Model
import Stores
import CommonView
import Router

public struct UserListView: View {
    @EnvironmentObject var usersStore: UsersStore
    @EnvironmentObject var naviRouter: NavigationRouter

    public init() {}

    public var body: some View {
        NavigationStack(path: $naviRouter.userPath) {
            VStack {
                LoadingView(isLoading: $usersStore.isLoading)
                List(usersStore.users) { user in
                    UserListChildView(user: user,
                                      pathContext: .user)
                }
            }
            .task {
                await usersStore.fetchUsers()
            }
            .navigationDestination(for: UserPath.self) { path in
                switch path {
                case .detail(let name):
                    UserDetailView(name: name)
                case .repoWebView(let url):
                    ViewControllerRepresentable(url: url)
                }
            }
            .navigationTitle("UserList")
            .navigationBarTitleDisplayMode(.inline)
            .alert(item: $usersStore.usersError) { alertData in
                Alert(title: Text(alertData.error.message()))
            }
        }
    }
}

public struct UserListChildView: View {
    @EnvironmentObject var naviRouter: NavigationRouter
    @EnvironmentObject var usersStore: UsersStore
    let user: UserModel
    let pathContext: PathContext

    public init(user: UserModel, pathContext: PathContext) {
        self.user = user
        self.pathContext = pathContext
    }

    public var body: some View {
        HStack {
            Button(user.userName) {
                switch pathContext {
                case .user:
                    naviRouter.pushUser(.detail(name: user.userName))
                case .favourite:
                    naviRouter.pushFavourite(.detail(name: user.userName))
                case .profile:
                    break
                }
            }
            .foregroundColor(.blue)
            .buttonStyle(PlainButtonStyle())
            Spacer()
            AsyncImage(url: user.avatarUrl) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "person")
            }
            .scaledToFit()
            .frame(height: 50)
            .clipShape(Circle())
            Button(action: {
                if user.isFavourite {
                    usersStore.deleteFavourite(user: user)
                } else {
                    usersStore.addFavourite(user: user)
                }
            }, label: {
                user.isFavourite ? Image(systemName: "suit.heart.fill") : Image(systemName: "suit.heart")
            })
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    UserListView()
        .environmentObject(NavigationRouter.shared)
        .environmentObject(UsersStore.shared)
}
