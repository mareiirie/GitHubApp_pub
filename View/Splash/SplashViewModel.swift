//
//  SplashViewModel.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/13.
//

import Foundation
import SwiftUI
import API
import Model
import Repository

enum SplashState {
    case stay
    case shouldShowAlertUpdate(_ shouldShow: Bool)
    case toLogin
    case toHome
    case error(message: String)
}

enum MainViewOrError: Equatable {
    case empty
    case error(message: String)
}

final class SplashViewModel: ObservableObject {
    // UIState
    @Published var toHome: Bool = false
    @Published var toLogin: Bool = false
    @Published var mainView: MainViewOrError = .empty
    @Published var isLoading: Bool = false
    @Published var showAlertUpdate: Bool = false
    // Dependency
    var api: API = API.value
    let userDefault = UserDefaultRepository()

    @MainActor
    func onAppear() async {
        isLoading = true
        resolveState(await checkStatus())
        isLoading = false
    }

    // stateのmutateはr必ずresolveStateで行うことで安心
    @MainActor
    private func resolveState(_ state: SplashState) {
        switch state {
        case .stay:
            return
        case .shouldShowAlertUpdate(_):
            self.showAlertUpdate = true
        case .toHome:
            self.toHome = true
        case .toLogin:
            self.toLogin = true
        case .error(let message):
            self.mainView = .error(message: message)
        }
    }

    // 複雑な状態の分岐はSplashStateを返す関数で行うことで安全
    @MainActor
    private func checkStatus() async -> SplashState {
        do {
            let update = try await api.checkUpdate()
            let shouldUpdate = update.shouldUpdate
            let isLogin = userDefault.loadLoginUser() != nil
            if shouldUpdate {
                return .shouldShowAlertUpdate(true)
            } else {
                if isLogin {
                    return .toHome
                } else {
                    return .toLogin
                }
            }
        } catch {
            guard let appError = error as? AppErrorType else {
                return .error(message: error.localizedDescription)
            }
            return .error(message: appError.message())
        }
    }
}
