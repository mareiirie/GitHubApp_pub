//
//  GithubAppApp.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/12.
//

import SwiftUI
import Router

@main
struct GithubAppApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(RootRouter.shared)
        }
    }
}
