//
//  RootRouter.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/13.
//

import SwiftUI
import Repository

@MainActor
public final class RootRouter: ObservableObject {

    public static let shared: RootRouter = .init()
    
    private init() {}

    @Published public var isLogin: Bool = false

    let userDefault = UserDefaultRepository()

    public func logout() {
        userDefault.deleteLoginUser()
        isLogin = false
    }

    public func login(name: String) {
        userDefault.saveLogin(name: name)
        isLogin = true
    }
}
