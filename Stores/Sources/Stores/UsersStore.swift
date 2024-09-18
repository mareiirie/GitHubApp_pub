//
//  UserStore.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/12.
//

import Foundation
import API
import Model

@MainActor
public final class UsersStore: ObservableObject {
    @Published public var users: [UserModel] = []
    @Published public var usersError: AppError?
    @Published public var isLoading = false
    
    // APIフェッチ時にリセットされないように。本来ならAPIのResponseだけでいいはず
    private var favUsers: [UserModel] = []

    var api = API.value
    
    public static let shared: UsersStore = .init()
    private init() {}

    @MainActor
    public func fetchUsers() async {
        isLoading = true
        do {
            let usersResponse = try await api.getUsers(nil)
            let new = usersResponse.map { user in
                var updatedUser = user
                if favUsers.contains(updatedUser) {
                    updatedUser.isFavourite = true
                }
                return updatedUser
            }
            self.users = new
            print("\(users)")
        } catch {
            guard let errorType = error as? AppErrorType else { return }
            self.usersError = AppError(error: errorType)
        }
        isLoading = false
    }
    
    public func addFavourite(user: UserModel) {
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            favUsers.append(user)
            users[index].isFavourite = true
        }
    }
    
    public func deleteFavourite(user: UserModel) {
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            print(favUsers)
            favUsers.removeAll(where: { $0.id == user.id })
            users[index].isFavourite = false
        }
    }
    
    public func deleteAllFavourite() {
        let new = users.map { user in
            var updatedUser = user
            updatedUser.isFavourite = false
            return updatedUser
        }
        favUsers.removeAll()
        users = new
    }

}
