//
//  ContentView.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/13.
//

import SwiftUI
import CommonView
import Router
import Stores

struct SplashView: View {

    @StateObject private var viewModel = SplashViewModel()
    @EnvironmentObject var rootRouter: RootRouter

    var body: some View {
        VStack {
            LoadingView(isLoading: $viewModel.isLoading)
            SplashMainView(mainView: $viewModel.mainView)
        }
        .task {
            await viewModel.onAppear()
        }
        .alert(isPresented: $viewModel.showAlertUpdate) {
            Alert(title: Text("Need Update Now!"))
        }
        .onChange(of: rootRouter.isLogin) {
            Task {
                await viewModel.onAppear()
            }
        }
        .fullScreenCover(isPresented: $viewModel.toHome) {
            MainView()
        }
        .fullScreenCover(isPresented: $viewModel.toLogin) {
            LoginView()
        }
        .environmentObject(NavigationRouter.shared)
        .environmentObject(UsersStore.shared)
    }
}

#Preview {
    SplashView()
        .environmentObject(RootRouter.shared)
        .environmentObject(UsersStore.shared)
}

struct SplashMainView: View {
    @Binding var mainView: MainViewOrError

    @ViewBuilder
    var body: some View {
        switch mainView {
        case .error(let message):
            Text(message)

        case .empty:
            Text("Welcome!")
        }
    }
}
