//
//  RegisterView.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/13.
//

import SwiftUI
import Router

struct RegisterView: View {

    @State var inputName = ""
    @EnvironmentObject var rootRouter: RootRouter

    var body: some View {
        TextField("input your user name", text: $inputName)
            .textFieldStyle(.roundedBorder)
            .padding()
            .onSubmit {
                rootRouter.login(name: inputName)
            }
    }
}

#Preview {
    RegisterView()
        .environmentObject(RootRouter.shared)
}
