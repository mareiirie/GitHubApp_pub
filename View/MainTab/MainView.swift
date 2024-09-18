//
//  MainView.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/13.
//

import SwiftUI
import Router
import FavouriteView
import UserView
import ProfileView
import Stores

struct MainView: View {
    @EnvironmentObject var naviRouter: NavigationRouter
    @EnvironmentObject var rootRouter: RootRouter
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        TabView(selection: $naviRouter.selectedTab) {
            UserListView()
                .tabItem {
                    Label("User", systemImage: "person.3")
                }
                .tag(1)
            FavouriteListView()
                .tabItem {
                    Label("Favourite", systemImage: "heart")
                }
                .tag(2)
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(3)
        }
        .onChange(of: rootRouter.isLogin) { old, new in
            let isLogin = new
            if !isLogin {
                dismiss()
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(NavigationRouter.shared)
        .environmentObject(RootRouter.shared)
        .environmentObject(UsersStore.shared)
}
