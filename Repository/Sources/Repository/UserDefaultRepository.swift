//
//  UserDefaultRepository.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/13.
//

import Foundation

enum UserDefaultKey: String {
    case userLoginName
}

public struct UserDefaultRepository {

    public init() {}

    public func saveLogin(name: String) {
        UserDefaults.standard.set(name, forKey: UserDefaultKey.userLoginName.rawValue)
    }

    public func loadLoginUser() -> String? {
        let name = UserDefaults.standard.string(forKey: UserDefaultKey.userLoginName.rawValue)
        return name
    }

    public func deleteLoginUser() {
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.userLoginName.rawValue)
    }

}
