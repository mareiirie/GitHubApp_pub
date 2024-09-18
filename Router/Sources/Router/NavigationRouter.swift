//
//  NavigationRouter.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/13.
//

import Foundation
import SwiftUI

@MainActor
public final class NavigationRouter: ObservableObject {
    
    public static let shared: NavigationRouter = NavigationRouter()
    private init(){}

    public enum MainTab: Int {
        case user = 1
        case favourite = 2
        case profile = 3
    }
    @Published public var selectedTab: Int = 1
    @Published public var userPath: [UserPath] = []
    @Published public var favouritePath: [FavouritePath] = []
    @Published public var profilePath: [ProfilePath] = []

    public func changeTab(toTab: MainTab) {
        selectedTab = toTab.rawValue
    }

    // User
    public func pushUser(_ path: UserPath) {
        userPath.append(path)
    }
    public func popUser() {
        _ = userPath.popLast()
    }
    public func popUserRoot() {
        userPath.removeAll()
    }

    // Favourite
    public func pushFavourite(_ path: FavouritePath) {
        favouritePath.append(path)
    }

    // Profile
    public func pushProfile(_ path: ProfilePath) {
        profilePath.append(path)
    }

    // Jump すでに表示中の場合、重複でappendされてしまうので、removeAllをする
    public func jumpToUserDetail(name: String) {
        userPath.removeAll()
        userPath.append(contentsOf: [.detail(name: name)])
        selectedTab = MainTab.user.rawValue
    }
}

public enum UserPath: Hashable {
    case detail(name: String)
    case repoWebView(url: URL)
}

public enum FavouritePath: Hashable {
    case detail(name: String)
    case repoWebView(url: URL)
}

public enum ProfilePath: Hashable {
    case repoWebView(url: URL)
}
