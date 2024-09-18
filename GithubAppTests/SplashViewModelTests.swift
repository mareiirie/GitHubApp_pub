//
//  SplashViewModelTests.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/13.
//

import XCTest
@testable import GithubApp
import API
import Repository
import Model

final class swiftui_new_arcTests: XCTestCase {

    let userDefault = UserDefaultRepository()

    override func setUpWithError() throws {
        userDefault.deleteLoginUser()
    }

    /*
     ログイン：未ログイン
     アップデート：不要
    */
    @MainActor
    func test_1() async throws {
        let viewModel = SplashViewModel()
        viewModel.api.checkUpdate = { .init(shouldUpdate: false) }
        await viewModel.onAppear()

        // 未ログインならtoLogin
        XCTAssertEqual(viewModel.toHome, false)
        XCTAssertEqual(viewModel.toLogin, true)
        XCTAssertEqual(viewModel.mainView, MainViewOrError.empty)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showAlertUpdate, false)
    }

    /*
     ログイン：未ログイン
     アップデート：必要
    */
    @MainActor
    func test_2() async throws {
        let viewModel = SplashViewModel()
        viewModel.api.checkUpdate = { .init(shouldUpdate: true) }
        await viewModel.onAppear()

        // アップデートが必要ならshowAlertUpdate
        XCTAssertEqual(viewModel.toHome, false)
        XCTAssertEqual(viewModel.toLogin, false)
        XCTAssertEqual(viewModel.mainView, MainViewOrError.empty)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showAlertUpdate, true)
    }

    /*
     ログイン：ログイン済
     アップデート：不要
    */
    @MainActor
    func test_3() async throws {
        userDefault.saveLogin(name: "TestUser")
        let viewModel = SplashViewModel()
        viewModel.api.checkUpdate = { .init(shouldUpdate: false) }
        await viewModel.onAppear()

        // ログイン済みならtoHome
        XCTAssertEqual(viewModel.toHome, true)
        XCTAssertEqual(viewModel.toLogin, false)
        XCTAssertEqual(viewModel.mainView, MainViewOrError.empty)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showAlertUpdate, false)
    }

    /*
     ログイン：ログイン済
     アップデート：必要
    */
    @MainActor
    func test_4() async throws {
        userDefault.saveLogin(name: "TestUser")
        let viewModel = SplashViewModel()
        viewModel.api.checkUpdate = { .init(shouldUpdate: false) }
        await viewModel.onAppear()

        // アップデートが必要ならshowAlertUpdate
        XCTAssertEqual(viewModel.toHome, true)
        XCTAssertEqual(viewModel.toLogin, false)
        XCTAssertEqual(viewModel.mainView, MainViewOrError.empty)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showAlertUpdate, false)
    }

    /*
     api エラー
    */
    @MainActor
    func test_5() async throws {
        let viewModel = SplashViewModel()
        viewModel.api.checkUpdate = { throw AppErrorType.decode }
        await viewModel.onAppear()

        // apiエラーならMainViewOrError.error
        XCTAssertEqual(viewModel.toHome, false)
        XCTAssertEqual(viewModel.toLogin, false)
        XCTAssertEqual(viewModel.mainView, MainViewOrError.error(message: AppErrorType.decode.message()))
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showAlertUpdate, false)
    }

}
