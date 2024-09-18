//
//  HalfView.swift
//  GithubApp
//
//  Created by 入江真礼 on 2024/09/14.
//

import SwiftUI
import Stores

struct HalfView: View {

    @EnvironmentObject var usersStore: UsersStore
    @Binding var isShowing: Bool

    var body: some View {

        Button("Delete All Favourite") {
            usersStore.deleteAllFavourite()
        }
        
        Button("dismiss") {
            isShowing = false
        }
    }
}
