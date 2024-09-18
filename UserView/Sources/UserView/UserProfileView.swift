//
//  UserProfileView.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/13.
//

import Foundation
import SwiftUI

public struct UserProfileView: View {
    let userName: String
    let avatarUrl: URL
    let fullName: String?
    let followersCount: Int
    let followingCount: Int

    public init(userName: String, avatarUrl: URL, fullName: String?, followersCount: Int, followingCount: Int) {
        self.userName = userName
        self.avatarUrl = avatarUrl
        self.fullName = fullName
        self.followersCount = followersCount
        self.followingCount = followingCount
    }

    public var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(userName)
                Spacer()
                AsyncImage(url: avatarUrl) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "person")
                }
                .scaledToFit()
                .frame(height: 50)
                .clipShape(Circle())
                Spacer()
            }
            HStack {
                Spacer()
                Text(fullName ?? "")
                Spacer()
                VStack {
                    Text("Followers: \(followersCount)")
                    Spacer()
                    Text("Following: \(followersCount)")
                }
                Spacer()
            }
            .frame(height: 50)
        }
    }
}

#Preview {
    UserProfileView(userName: "hoge",
                    avatarUrl: URL(string: "https://www.google.co.jp")!,
                    fullName: "hogefuga",
                    followersCount: 1,
                    followingCount: 1)
}
