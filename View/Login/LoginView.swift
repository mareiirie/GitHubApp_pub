//
//  LoginView.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/13.
//

import SwiftUI
import Router

struct LoginView: View {

    @State var inputName = ""
    @EnvironmentObject var rootRouter: RootRouter
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            TextField("input your user name", text: $inputName)
                .textFieldStyle(.roundedBorder)
                .padding()
                .onSubmit {
                    rootRouter.login(name: inputName)
                }
            NavigationLink("No Account? Register from here") {
                RegisterView()
            }
        }
        .onChange(of: rootRouter.isLogin) { old, new in
            let isLogin = new
            if isLogin {
                dismiss()
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(RootRouter.shared)
}
