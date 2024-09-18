//
//  FavouriteListView.swift
//  GithubApp
//
//  Created by 入江真礼 on 2024/09/14.
//

import SwiftUI
import Model
import CommonView
import Stores
import Router
import UserView

public struct FavouriteListView: View {
    @EnvironmentObject var usersStore: UsersStore
    @EnvironmentObject var naviRouter: NavigationRouter

    @State private var isShowSheet = false

    public init() {}

    public var body: some View {
        NavigationStack(path: $naviRouter.favouritePath) {
            VStack {
                Button("Show Action Sheet") {
                    isShowSheet = true
                }
                List(filteredFavoriteUsers(users: usersStore.users)) { user in
                    UserListChildView(user: user,
                                      pathContext: .favourite)
                }
            }
            .navigationDestination(for: FavouritePath.self) { path in
                switch path {
                case .detail(let name):
                    UserDetailView(name: name)
                case .repoWebView(let url):
                    ViewControllerRepresentable(url: url)
                }
            }
            .navigationTitle("FavouriteList")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isShowSheet) {
                HalfView(isShowing: $isShowSheet)
                    .presentationDetents([.medium])
            }
        }
    }
    
    private func filteredFavoriteUsers(users: [UserModel]) -> [UserModel] {
        return users.filter { $0.isFavourite }
    }
}

#Preview {
    FavouriteListView()
        .environmentObject(UsersStore.shared)
        .environmentObject(NavigationRouter.shared)
}
